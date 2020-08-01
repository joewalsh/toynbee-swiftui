import Foundation
import Combine

enum ToynbeeModelError: Error {
    case generic
}

class ToynbeeModel: ObservableObject {
    init() {
        load()
    }
    
    @Published private(set) var origin: Stop = Stop.villanova {
        didSet {
            fetch()
        }
    }
    
    @Published private(set) var destination: Stop = Stop.airportTerminalA {
        didSet {
            fetch()
        }
    }
    
    @Published private(set) var favoriteStops: [Stop] = [Stop.thirteithStreetStation, Stop.suburbanStation, Stop.jeffersonStation]
    
    @Published private(set) var trips: [Trip] = [] {
        didSet {
            isBusy = false
        }
    }
    
    enum StopSelectionState {
        case origin
        case destination
    }
    
    @Published var isSelectingStop: Bool = false
    @Published private(set) var stopSelectionState: StopSelectionState = .origin
    
    public let stops: [Stop] = Stop.allCases
    
    @Published private(set) var isBusy: Bool = false

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
            let persistence = ToynbeeModelPersistence(origin: origin, destination: destination, favoriteStops: favoriteStops)
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
            origin = persistence.origin
            destination = persistence.destination
            favoriteStops = persistence.favoriteStops
        } catch let error {
            print("error saving: \(error)")
        }
    }
}

struct ToynbeeModelPersistence: Codable {
    let origin: Stop
    let destination: Stop
    let favoriteStops: [Stop]
}

// MARK: Mutators
extension ToynbeeModel {
    func fetch() {
        if let currentRequest = cancelable {
            currentRequest.cancel()
        }
        isBusy = true
        cancelable = api.getTrips(from: origin, to: destination)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.trips, on: self)
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
