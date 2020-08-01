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
