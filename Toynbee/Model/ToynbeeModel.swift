import Foundation
import Combine

enum ToynbeeModelError: Error {
    case generic
}

class ToynbeeModel: ObservableObject {
    init() {
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
    
    public let stops: [Stop] = Stop.byID.values.sorted { $0.name < $1.name }
    
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
            let persistence = ToynbeeModelPersistence(originID: origin.id, destinationID: destination.id)
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
        } catch let error {
            print("error saving: \(error)")
        }
    }
}

struct ToynbeeModelPersistence: Codable {
    let originID: Int
    let destinationID: Int
}

// MARK: Mutators
extension ToynbeeModel {
    func fetch() {
        if let currentRequest = cancelable {
            currentRequest.cancel()
        }
        isBusy = true
        cancelable = api.getTrips(from: origin, to: destination).replaceError(with: []).receive(on: DispatchQueue.main).assign(to: \.trips, on: self)
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
}
