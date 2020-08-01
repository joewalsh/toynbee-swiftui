enum Line: String {
    case air
    case che
    case chw
    case lan
    case med
    case fox
    case nor
    case pao
    case cyn
    case tre
    case war
    case wil
    case wtr
    var code: String {
        return rawValue.uppercased()
    }
    var name: String {
        return Line.lookupName[self] ?? ""
    }
    
    private static let lookupName: [Line: String] = [
        .air: "Airport",
        .che: "Chestnut Hill East",
        .chw: "Chestnut Hill West",
        .lan: "Lansdale/Doylestown",
        .med: "Media/Elwyn",
        .fox: "Fox Chase",
        .nor: "Manayunk/Norristown",
        .pao: "Paoli/Thorndale",
        .cyn: "Cynwyd",
        .tre: "Trenton",
        .war: "Warminster",
        .wil: "Wilmington/Newark",
        .wtr: "West Trenton",
    ]
    
    private static let byName: [String: Line] = [
        "airport": .air,
        "chestnut hill east": .che,
        "chestnut hill west": .chw,
        "lansdale/doylestown": .lan,
        "media/elwyn": .med,
        "fox chase": .fox,
        "manayunk/norristown": .nor,
        "paoli/thorndale": .pao,
        "cynwyd": .cyn,
        "trenton": .tre,
        "warminster": .war,
        "wilmington/newark": .wil,
        "west trenton": .wtr,
    ]
    
    public static func with(name: String) -> Line? {
        return byName[name.lowercased()]
    }
}
