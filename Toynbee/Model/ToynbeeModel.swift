import Foundation
import Combine

enum ToynbeeModelError: Error, LocalizedError {
    case generic
}

class ToynbeeModel: ObservableObject {
    init(initialTripFetchState: TripFetchState) {
        tripFetchState = initialTripFetchState
        load()
    }
    
    @Published private(set) var origin: Stop = Stop.byID[90514]! {
        didSet {
            fetch()
        }
    }
    
    @Published private(set) var destination: Stop = Stop.byID[90404]! {
        didSet {
            fetch()
        }
    }
    
    @Published private(set) var favoriteStops: [Stop] = [Stop.byID[90004]!, Stop.byID[90005]!, Stop.byID[90006]!]
    

    enum TripFetchState {
        case fetching(_ trips: [Trip])
        case failure(_ error: LocalizedError)
        case empty
        case success(_ trips: [Trip])
    }
    
    @Published private(set) var tripFetchState: TripFetchState
    
    enum StopSelectionState {
        case origin
        case destination
    }
    
    @Published var isSelectingStop: Bool = false
    @Published private(set) var stopSelectionState: StopSelectionState = .origin
    
    public let stops: [Stop] = Stop.byID.values.sorted { $0.name < $1.name }
    
    private let api = API()
    private var cancelable: AnyCancellable?
    
    func getPersistenceFileURL() throws -> URL {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ToynbeeModelError.generic
        }
        return documentsDirectoryURL.appendingPathComponent("toynbee.json")
    }
    
    let fileQueue = DispatchQueue(label: "fileQueue")
    
    func save() {
        do {
            let peristenceFileURL = try getPersistenceFileURL()
            let persistence = ToynbeeModelPersistence(originID: origin.id, destinationID: destination.id, favoriteStopIDs: favoriteStops.map { $0.id })
            let data = try JSONEncoder().encode(persistence)
            try data.write(to: peristenceFileURL)
        } catch let error {
            print("error saving: \(error)")
        }
    }
    
    func load() {
        do {
            let peristenceFileURL = try getPersistenceFileURL()
            let data = try Data(contentsOf: peristenceFileURL)
            let persistence = try JSONDecoder().decode(ToynbeeModelPersistence.self, from: data)
            if let persistedOrigin = Stop.byID[persistence.originID] {
                origin = persistedOrigin
            }
            if let persistedDestination = Stop.byID[persistence.destinationID] {
                destination = persistedDestination
            }
            favoriteStops = persistence.favoriteStopIDs.compactMap { Stop.byID[$0] }
        } catch let error {
            print("error saving: \(error)")
        }
    }
}

struct ToynbeeModelPersistence: Codable {
    let originID: Int
    let destinationID: Int
    let favoriteStopIDs: [Int]
}

// MARK: Mutators
extension ToynbeeModel {
    func fetch() {
        if let currentRequest = cancelable {
            currentRequest.cancel()
        }
        
        let fetchingTrips: [Trip]
        switch tripFetchState {
        case .success(let trips):
            fetchingTrips = trips
        default:
            fetchingTrips = []
        }
        
        tripFetchState = .fetching(fetchingTrips)
        
        cancelable = api.getTrips(from: origin, to: destination)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
                switch result {
                case .failure(let error):
                    self.tripFetchState = .failure(error as? LocalizedError ?? ToynbeeModelError.generic)
                case .finished:
                    break
                }
            }, receiveValue: { (value) in
                if value.isEmpty {
                    self.tripFetchState = .empty
                } else {
                    self.tripFetchState = .success(value)
                }
            })
    }

    func selectOrigin() {
        stopSelectionState = .origin
        isSelectingStop = true
    }
    
    func selectDestination() {
        stopSelectionState = .destination
        isSelectingStop = true
    }
    
    func cancelStopSelection() {
        isSelectingStop = false
    }
    
    func select(stop: Stop) {
        switch stopSelectionState {
        case .origin:
            origin = stop
        case .destination:
            destination = stop
        }
        cancelStopSelection()
        DispatchQueue.global(qos: .background).async {
            self.save()
        }
    }
    
    func addFavorite(stop: Stop) {
        guard !favoriteStops.contains(stop) else {
            return
        }
        favoriteStops.append(stop)
    }
}
