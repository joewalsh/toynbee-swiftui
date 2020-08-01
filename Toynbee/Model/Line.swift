enum Line: String {
    case AIR
    case CHE
    case CHW
    case LAN
    case MED
    case FOX
    case NOR
    case PAO
    case CYN
    case TRE
    case WAR
    case WIL
    case WTR
    
    var code: String {
        return rawValue
    }

    private static let byName: [String: Line] = [
        "airport": .AIR,
        "chestnut hill east": .CHE,
        "chestnut hill west": .CHW,
        "lansdale/doylestown": .LAN,
        "media/elwyn": .MED,
        "fox chase": .FOX,
        "manayunk/norristown": .NOR,
        "paoli/thorndale": .PAO,
        "cynwyd": .CYN,
        "trenton": .TRE,
        "warminster": .WAR,
        "wilmington/newark": .WIL,
        "west trenton": .WTR,
    ]
    
    public static func with(name: String) -> Line? {
        return byName[name.lowercased()]
    }
}
