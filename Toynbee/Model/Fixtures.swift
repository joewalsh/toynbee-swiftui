import Foundation

extension ToynbeeModel {
    static let fixture = ToynbeeModel()
}

extension Trip {
    static let jsonString = """
    [{"orig_train":"1530","orig_line":"Paoli/Thorndale","orig_departure_time":"2:12PM","orig_arrival_time":"2:41PM","orig_delay":"1 min","term_train":"9443","term_line":"Airport","term_depart_time":"2:59PM","term_arrival_time":"3:17PM","Connection":"30th Street Station","term_delay":"On time","isdirect":"false"},{"orig_train":"5332","orig_line":"Paoli/Thorndale","orig_departure_time":"2:47PM","orig_arrival_time":"3:15PM","orig_delay":"On time","term_train":"445","term_line":"Airport","term_depart_time":"3:29PM","term_arrival_time":"3:47PM","Connection":"30th Street Station","term_delay":"On time","isdirect":"false"},{"orig_train":"1534","orig_line":"Paoli/Thorndale","orig_departure_time":"3:12PM","orig_arrival_time":"3:41PM","orig_delay":"On time","term_train":"9447","term_line":"Airport","term_depart_time":"3:59PM","term_arrival_time":"4:17PM","Connection":"30th Street Station","term_delay":"On time","isdirect":"false"},{"orig_train":"5336","orig_line":"Paoli/Thorndale","orig_departure_time":"3:47PM","orig_arrival_time":"4:15PM","orig_delay":"On time","term_train":"449","term_line":"Airport","term_depart_time":"4:29PM","term_arrival_time":"4:47PM","Connection":"30th Street Station","term_delay":"On time","isdirect":"false"}]
    """
    static let fixtures: [Trip] = {
        let context = ExpectedTime.Context()
        return try! JSONDecoder()
            .decode([TripJSON].self, from: jsonString.data(using: .utf8)!)
            .compactMap { Trip(json: $0, context: context) }
    }()
}


