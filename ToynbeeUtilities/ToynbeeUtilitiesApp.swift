import SwiftUI

@main
struct ToynbeeUtilitiesApp: App {
    static func main() {
        writeStopsByID()
    }
    
    private static func writeStopsByID() {
        guard let stopsFileURL = Bundle.main.url(forResource: "stops", withExtension: "txt", subdirectory: "google_rail") else {
            return
        }
        do {
            let stopsFileContents = try String(contentsOf: stopsFileURL)
            let stopsFileLines = stopsFileContents.components(separatedBy: CharacterSet.newlines)
            let stopsByID = try stopsFileLines.reduce(into: [Int:Stop](minimumCapacity: stopsFileLines.count)) { (byID, stopsFileLine) in
                let stopFields = stopsFileLine.split(separator: ",")
                guard stopFields.count >= 7 else {
                    return
                }
                guard
                    let id = Int(stopFields[0]),
                    let latitude = Double(stopFields[3]),
                    let longitude = Double(stopFields[4])
                else {
                    return
                }
                guard let param = Lookup.Stop.Param.by(id: id) else {
                    return
                }
                let name = String(stopFields[1])
                byID[id] = Stop(id: id, name: name, param: param, latitude: latitude, longitude: longitude)
            }
            let path = URL.init(fileURLWithPath: NSTemporaryDirectory().appending("blah.json"))
            let jsonData = try JSONEncoder().encode(stopsByID)
            try jsonData.write(to: path)
        } catch let error {
            print("error reading stops file: \(error)")
            return
        }
    }
    
}
