enum Stop: Int, CaseIterable, Codable, Identifiable, Hashable {
    var id: Int {
        return rawValue
    }

    case thirteithStreetStation = 90004
    case fortyNinthStreet = 90314
    case ninthStreetLansdale = 90539
    case airportTerminalA = 90404
    case airportTerminalB = 90403
    case airportTerminalCD = 90402
    case airportTerminalEF = 90401
    case allegheny = 90218
    case allenLane = 90804
    case ambler = 90526
    case angora = 90313
    case ardmore = 90518
    case ardsley = 90412
    case bala = 90002
    case berwyn = 90508
    case bethayres = 90318
    case bridesburg = 90710
    case bristol = 90703
    case brynMawr = 90516
    case carpenter = 90805
    case chalfont = 90535
    case cheltenAvenue = 90808
    case cheltenham = 90813
    case chester = 90207
    case chestnutHillEast = 90720
    case chestnutHillWest = 90801
    case churchmansCrossing = 90202
    case claymont = 90204
    case cliftonAldan = 90309
    case colmar = 90533
    case conshohocken = 90225
    case cornwellsHeights = 90706
    case crestmont = 90414
    case croydon = 90704
    case crumLynne = 90209
    case curtisPark = 90216
    case cynwyd = 90001
    case darby = 90217
    case daylesford = 90507
    case delawareValleyCollege = 90537
    case devon = 90509
    case downingtown = 90502
    case doylestown = 90538
    case eastFalls = 90219
    case eastwick = 90405
    case eddington = 90705
    case eddystone = 90208
    case elkinsPark = 90409
    case elwyn = 90301
    case exton = 90504
    case fernRockTC = 90407
    case fernwoodYeadon = 90312
    case folcroft = 90214
    case forestHills = 90320
    case fortWashington = 90525
    case fortuna = 90532
    case foxChase = 90815
    case germantown = 90713
    case gladstone = 90310
    case glenolden = 90213
    case glenside = 90411
    case gravers = 90719
    case gwyneddValley = 90528
    case hatboro = 90416
    case haverford = 90517
    case highland = 90802
    case highlandAvenue = 90206
    case holmesburgJct = 90708
    case ivyRidge = 90222
    case jeffersonStation = 90006
    case jenkintownWyncote = 90410
    case langhorne = 90324
    case lansdale = 90531
    case lansdowne = 90311
    case lawndale = 90812
    case levittownTullytown = 90702
    case linkBelt = 90534
    case mainStreet = 90227
    case malvern = 90505
    case manayunk = 90221
    case marcusHook = 90205
    case meadowbrook = 90317
    case media = 90302
    case melrosePark = 90408
    case merion = 90521
    case miquon = 90223
    case mortonRutledge = 90306
    case mountAiry = 90717
    case moylanRoseValley = 90303
    case narberth = 90520
    case neshaminy = 90323
    case newBritain = 90536
    case newark = 90201
    case noble = 90315
    case norristownElmStreet = 90228
    case norristownTC = 90226
    case northBroad = 90008
    case northHills = 90523
    case northPhiladelphia = 90810
    case northPhiladelphiaAmtrak = 90711
    case northWales = 90529
    case norwood = 90212
    case olney = 90811
    case oreland = 90524
    case overbrook = 90522
    case paoli = 90506
    case penllyn = 90527
    case pennbrook = 90530
    case philmont = 90319
    case primos = 90308
    case prospectParkMoore = 90211
    case queenLane = 90809
    case radnor = 90513
    case ridleyPark = 90210
    case rosemont = 90515
    case roslyn = 90413
    case rydal = 90316
    case ryers = 90814
    case secane = 90307
    case sedgwick = 90716
    case sharonHill = 90215
    case somerton = 90321
    case springMill = 90224
    case stDavids = 90512
    case stMartins = 90803
    case stenton = 90715
    case strafford = 90510
    case suburbanStation = 90005
    case swarthmore = 90305
    case tacony = 90709
    case templeUniversity = 90007
    case thorndale = 90501
    case torresdale = 90707
    case trenton = 90701
    case trevose = 90322
    case tulpehocken = 90807
    case universityCity = 90406
    case upsal = 90806
    case villanova = 90514
    case wallingford = 90304
    case warminster = 90417
    case washingtonLane = 90714
    case wayne = 90511
    case wayneJunction = 90009
    case westTrenton = 90327
    case whitford = 90503
    case willowGrove = 90415
    case wilmington = 90203
    case wissahickon = 90220
    case wister = 90712
    case woodbourne = 90325
    case wyndmoor = 90718
    case wynnefieldAvenue = 90003
    case wynnewood = 90519
    case yardley = 90326

    var param: String {
        return Stop.lookupParam[self] ?? ""
    }

    static let lookupParam: [Stop: String] = [
        .thirteithStreetStation: "30th Street Station",
        .fortyNinthStreet: "49th St",
        .ninthStreetLansdale: "9th St",
        .airportTerminalA: "Airport Terminal A",
        .airportTerminalB: "Airport Terminal B",
        .airportTerminalCD: "Airport Terminal C-D",
        .airportTerminalEF: "Airport Terminal E-F",
        .allegheny: "Allegheny",
        .allenLane: "Allen Lane",
        .ambler: "Ambler",
        .angora: "Angora",
        .ardmore: "Ardmore",
        .ardsley: "Ardsley",
        .bala: "Bala",
        .berwyn: "Berwyn",
        .bethayres: "Bethayres",
        .bridesburg: "Bridesburg",
        .bristol: "Bristol",
        .brynMawr: "Bryn Mawr",
        .carpenter: "Carpenter",
        .chalfont: "Chalfont",
        .cheltenAvenue: "Chelten Avenue",
        .cheltenham: "Cheltenham",
        .chester: "Chester TC",
        .chestnutHillEast: "Chestnut Hill East",
        .chestnutHillWest: "Chestnut Hill West",
        .churchmansCrossing: "Churchmans Crossing",
        .claymont: "Claymont",
        .cliftonAldan: "Clifton-Aldan",
        .colmar: "Colmar",
        .conshohocken: "Conshohocken",
        .cornwellsHeights: "Cornwells Heights",
        .crestmont: "Crestmont",
        .croydon: "Croydon",
        .crumLynne: "Crum Lynne",
        .curtisPark: "Curtis Park",
        .cynwyd: "Cynwyd",
        .darby: "Darby",
        .daylesford: "Daylesford",
        .delawareValleyCollege: "Delaware Valley College",
        .devon: "Devon",
        .downingtown: "Downingtown",
        .doylestown: "Doylestown",
        .eastFalls: "East Falls",
        .eastwick: "Eastwick",
        .eddington: "Eddington",
        .eddystone: "Eddystone",
        .elkinsPark: "Elkins Park",
        .elwyn: "Elwyn Station",
        .exton: "Exton",
        .fernRockTC: "Fern Rock TC",
        .fernwoodYeadon: "Fernwood",
        .folcroft: "Folcroft",
        .forestHills: "Forest Hills",
        .fortWashington: "Ft Washington",
        .fortuna: "Fortuna",
        .foxChase: "Fox Chase",
        .germantown: "Germantown",
        .gladstone: "Gladstone",
        .glenolden: "Glenolden",
        .glenside: "Glenside",
        .gravers: "Gravers",
        .gwyneddValley: "Gwynedd Valley",
        .hatboro: "Hatboro",
        .haverford: "Haverford",
        .highland: "Highland",
        .highlandAvenue: "Highland Avenue",
        .holmesburgJct: "Holmesburg Jct",
        .ivyRidge: "Ivy Ridge",
        .jeffersonStation: "Jefferson Station",
        .jenkintownWyncote: "Jenkintown-Wyncote",
        .langhorne: "Langhorne",
        .lansdale: "Lansdale",
        .lansdowne: "Lansdowne",
        .lawndale: "Lawndale",
        .levittownTullytown: "Levittown-Tullytown",
        .linkBelt: "Link Belt",
        .mainStreet: "Main Street",
        .malvern: "Malvern",
        .manayunk: "Manayunk",
        .marcusHook: "Marcus Hook",
        .meadowbrook: "Meadowbrook",
        .media: "Media",
        .melrosePark: "Melrose Park",
        .merion: "Merion",
        .miquon: "Miquon",
        .mortonRutledge: "Morton-Rutledge",
        .mountAiry: "Mount Airy",
        .moylanRoseValley: "Moylan-Rose Valley",
        .narberth: "Narberth",
        .neshaminy: "Neshaminy",
        .newBritain: "New Britain",
        .newark: "Newark",
        .noble: "Noble",
        .norristownElmStreet: "Elm St",
        .norristownTC: "Norristown TC",
        .northBroad: "North Broad",
        .northHills: "North Hills",
        .northPhiladelphia: "North Philadelphia",
        .northPhiladelphiaAmtrak: "North Philadelphia Amtrak",
        .northWales: "North Wales",
        .norwood: "Norwood",
        .olney: "Olney",
        .oreland: "Oreland",
        .overbrook: "Overbrook",
        .paoli: "Paoli",
        .penllyn: "Penllyn",
        .pennbrook: "Pennbrook",
        .philmont: "Philmont",
        .primos: "Primos",
        .prospectParkMoore: "Prospect Park",
        .queenLane: "Queen Lane",
        .radnor: "Radnor",
        .ridleyPark: "Ridley Park",
        .rosemont: "Rosemont",
        .roslyn: "Roslyn",
        .rydal: "Rydal",
        .ryers: "Ryers",
        .secane: "Secane",
        .sedgwick: "Sedgwick",
        .sharonHill: "Sharon Hill",
        .somerton: "Somerton",
        .springMill: "Spring Mill",
        .stDavids: "St. Davids",
        .stMartins: "St. Martins",
        .stenton: "Stenton",
        .strafford: "Strafford",
        .suburbanStation: "Suburban Station",
        .swarthmore: "Swarthmore",
        .tacony: "Tacony",
        .templeUniversity: "Temple University",
        .thorndale: "Thorndale",
        .torresdale: "Torresdale",
        .trenton: "Trenton",
        .trevose: "Trevose",
        .tulpehocken: "Tulpehocken",
        .universityCity: "University City",
        .upsal: "Upsal",
        .villanova: "Villanova",
        .wallingford: "Wallingford",
        .warminster: "Warminster",
        .washingtonLane: "Washington Lane",
        .wayne: "Wayne",
        .wayneJunction: "Wayne Junction",
        .westTrenton: "West Trenton",
        .whitford: "Whitford",
        .willowGrove: "Willow Grove",
        .wilmington: "Wilmington",
        .wissahickon: "Wissahickon",
        .wister: "Wister",
        .woodbourne: "Woodbourne",
        .wyndmoor: "Wyndmoor",
        .wynnefieldAvenue: "Wynnefield Avenue",
        .wynnewood: "Wynnewood",
        .yardley: "Yardley",
    ]

    var name: String {
        return Stop.lookupName[self] ?? ""
    }

    static let lookupName: [Stop: String] = [
        .thirteithStreetStation: "30th Street Station",
        .fortyNinthStreet: "49th Street",
        .ninthStreetLansdale: "9th Street Lansdale",
        .airportTerminalA: "Airport Terminal A",
        .airportTerminalB: "Airport Terminal B",
        .airportTerminalCD: "Airport Terminal C D",
        .airportTerminalEF: "Airport Terminal E F",
        .allegheny: "Allegheny",
        .allenLane: "Allen Lane",
        .ambler: "Ambler",
        .angora: "Angora",
        .ardmore: "Ardmore",
        .ardsley: "Ardsley",
        .bala: "Bala",
        .berwyn: "Berwyn",
        .bethayres: "Bethayres",
        .bridesburg: "Bridesburg",
        .bristol: "Bristol",
        .brynMawr: "Bryn Mawr",
        .carpenter: "Carpenter",
        .chalfont: "Chalfont",
        .cheltenAvenue: "Chelten Avenue",
        .cheltenham: "Cheltenham",
        .chester: "Chester",
        .chestnutHillEast: "Chestnut Hill East",
        .chestnutHillWest: "Chestnut Hill West",
        .churchmansCrossing: "Churchman's Crossing",
        .claymont: "Claymont",
        .cliftonAldan: "Clifton-Aldan",
        .colmar: "Colmar",
        .conshohocken: "Conshohocken",
        .cornwellsHeights: "Cornwells Heights",
        .crestmont: "Crestmont",
        .croydon: "Croydon",
        .crumLynne: "Crum Lynne",
        .curtisPark: "Curtis Park",
        .cynwyd: "Cynwyd",
        .darby: "Darby",
        .daylesford: "Daylesford",
        .delawareValleyCollege: "Delaware Valley College",
        .devon: "Devon",
        .downingtown: "Downingtown",
        .doylestown: "Doylestown",
        .eastFalls: "East Falls",
        .eastwick: "Eastwick",
        .eddington: "Eddington",
        .eddystone: "Eddystone",
        .elkinsPark: "Elkins Park",
        .elwyn: "Elwyn",
        .exton: "Exton",
        .fernRockTC: "Fern Rock T C",
        .fernwoodYeadon: "Fernwood-Yeadon",
        .folcroft: "Folcroft",
        .forestHills: "Forest Hills",
        .fortWashington: "Fort Washington",
        .fortuna: "Fortuna",
        .foxChase: "Fox Chase",
        .germantown: "Germantown",
        .gladstone: "Gladstone",
        .glenolden: "Glenolden",
        .glenside: "Glenside",
        .gravers: "Gravers",
        .gwyneddValley: "Gwynedd Valley",
        .hatboro: "Hatboro",
        .haverford: "Haverford",
        .highland: "Highland",
        .highlandAvenue: "Highland Avenue",
        .holmesburgJct: "Holmesburg Jct",
        .ivyRidge: "Ivy Ridge",
        .jeffersonStation: "Jefferson Station",
        .jenkintownWyncote: "Jenkintown Wyncote",
        .langhorne: "Langhorne",
        .lansdale: "Lansdale",
        .lansdowne: "Lansdowne",
        .lawndale: "Lawndale",
        .levittownTullytown: "Levittown-Tullytown",
        .linkBelt: "Link Belt",
        .mainStreet: "Main Street",
        .malvern: "Malvern",
        .manayunk: "Manayunk",
        .marcusHook: "Marcus Hook",
        .meadowbrook: "Meadowbrook",
        .media: "Media",
        .melrosePark: "Melrose Park",
        .merion: "Merion",
        .miquon: "Miquon",
        .mortonRutledge: "Morton-Rutledge",
        .mountAiry: "Mount Airy",
        .moylanRoseValley: "Moylan-Rose Valley",
        .narberth: "Narberth",
        .neshaminy: "Neshaminy",
        .newBritain: "New Britain",
        .newark: "Newark",
        .noble: "Noble",
        .norristownElmStreet: "Norristown Elm Street",
        .norristownTC: "Norristown T.C.",
        .northBroad: "North Broad",
        .northHills: "North Hills",
        .northPhiladelphia: "North Philadelphia",
        .northPhiladelphiaAmtrak: "North Philadelphia Amtrak",
        .northWales: "North Wales",
        .norwood: "Norwood",
        .olney: "Olney",
        .oreland: "Oreland",
        .overbrook: "Overbrook",
        .paoli: "Paoli",
        .penllyn: "Penllyn",
        .pennbrook: "Pennbrook",
        .philmont: "Philmont",
        .primos: "Primos",
        .prospectParkMoore: "Prospect Park - Moore",
        .queenLane: "Queen Lane",
        .radnor: "Radnor",
        .ridleyPark: "Ridley Park",
        .rosemont: "Rosemont",
        .roslyn: "Roslyn",
        .rydal: "Rydal",
        .ryers: "Ryers",
        .secane: "Secane",
        .sedgwick: "Sedgwick",
        .sharonHill: "Sharon Hill",
        .somerton: "Somerton",
        .springMill: "Spring Mill",
        .stDavids: "St. Davids",
        .stMartins: "St. Martins",
        .stenton: "Stenton",
        .strafford: "Strafford",
        .suburbanStation: "Suburban Station",
        .swarthmore: "Swarthmore",
        .tacony: "Tacony",
        .templeUniversity: "Temple University",
        .thorndale: "Thorndale",
        .torresdale: "Torresdale",
        .trenton: "Trenton",
        .trevose: "Trevose",
        .tulpehocken: "Tulpehocken",
        .universityCity: "University City",
        .upsal: "Upsal",
        .villanova: "Villanova",
        .wallingford: "Wallingford",
        .warminster: "Warminster",
        .washingtonLane: "Washington Lane",
        .wayne: "Wayne",
        .wayneJunction: "Wayne Junction",
        .westTrenton: "West Trenton",
        .whitford: "Whitford",
        .willowGrove: "Willow Grove",
        .wilmington: "Wilmington",
        .wissahickon: "Wissahickon",
        .wister: "Wister",
        .woodbourne: "Woodbourne",
        .wyndmoor: "Wyndmoor",
        .wynnefieldAvenue: "Wynnefield Avenue",
        .wynnewood: "Wynnewood",
        .yardley: "Yardley",
    ]
}
