import Foundation

struct Lookup {
    struct Line {
        struct Code {
            private static let _byName = [
                "airport": "AIR",
                "chestnut hill east": "CHE",
                "chestnut hill west": "CHW",
                "lansdale/doylestown": "LAN",
                "media/elwyn": "MED",
                "fox chase": "FOX",
                "manayunk/norristown": "NOR",
                "paoli/thorndale": "PAO",
                "cynwyd": "CYN",
                "trenton": "TRE",
                "warminster": "WAR",
                "wilmington/newark": "WIL",
                "west trenton": "WTR",
            ]
            public static func by(name: String) -> String {
                return _byName[name.lowercased()] ?? ""
            }
        }
    }
}
