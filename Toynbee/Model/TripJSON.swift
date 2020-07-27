/// API response JSON structure
struct TripJSON: Codable {
    let orig_train: String
    let orig_line: String
    let orig_departure_time: String
    let orig_arrival_time: String
    let orig_delay: String
    let isdirect: String
    let term_train: String?
    let term_line: String?
    let term_depart_time: String?
    let term_arrival_time: String?
    let term_delay: String?
    let Connection: String?
}
