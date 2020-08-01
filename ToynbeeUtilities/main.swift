
import Foundation


func writeStopsSwift() {
    do {
        let stopsFileLines = StopCSV.text.components(separatedBy: CharacterSet.newlines)
        let stopCSVs = stopsFileLines.compactMap { stopsFileLine -> StopCSV? in
            let stopFields = stopsFileLine.split(separator: ",")
            guard stopFields.count > 7 else {
                return nil
            }
            guard
                let id = Int(stopFields[0]),
                let latitude = Double(stopFields[3]),
                let longitude = Double(stopFields[4])
            else {
                return nil
            }
            let name = String(stopFields[1])
            let param = String(stopFields[7])
            /// We can be lazy about this because it's a separate utility, not the app
            let cleanedName = name
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: "'", with: "")
                .replacingOccurrences(of: "30th", with: "Thirteith")
                .replacingOccurrences(of: "49th", with: "FortyNinth")
                .replacingOccurrences(of: "9th", with: "Ninth")
            let caseName = cleanedName.lowercasedFirst()
            return StopCSV(id: id, name: name, param: param, caseName: caseName, location: StopCSV.Location(latitude: latitude, longitude: longitude))
        }.sorted { $0.name < $1.name }
        var swift = """
            enum Stop: Int, CaseIterable, Codable, Identifiable, Hashable {
                var id: Int {
                    return rawValue
                }


            """
        for stop in stopCSVs {
            swift.append("    case \(stop.caseName) = \(stop.id)\n")
        }
        
        swift.appendSwiftLookup(className: "Stop", propertyName: "param", propertyType: "String", values: stopCSVs, defaultValue: "\"\"", keyValueGetter: { (stop) -> (key: String, value: String) in
            return (key: stop.caseName, value: "\"\(stop.param)\"")
        })
        swift.appendSwiftLookup(className: "Stop", propertyName: "name", propertyType: "String", values: stopCSVs, defaultValue: "\"\"", keyValueGetter: { (stop) -> (key: String, value: String) in
            return (key: stop.caseName, value: "\"\(stop.name)\"")
        })
        swift.append("""
        }
        """)
        let path = URL.init(fileURLWithPath: NSTemporaryDirectory().appending("Stop.swift"))
        try swift.write(to: path, atomically: true, encoding: .utf8)
    } catch let error {
        print("error reading stops file: \(error)")
        return
    }
}

writeStopsSwift()
