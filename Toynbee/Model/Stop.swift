import Foundation

struct Stop: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let param: String
    let latitude: Double
    let longitude: Double
    
    static let byID: [Int: Stop] = {
        guard let stopsFileURL = Bundle.main.url(forResource: "StopsByID", withExtension: "json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: stopsFileURL)
            return try JSONDecoder().decode([Int: Stop].self, from: data)
        } catch let error {
            print("error reading stops file: \(error)")
            return [:]
        }
    }()
}
