import Foundation

/// A given train trip - departure, arrival, time
struct Train {
    struct Line {
        let name: String
        let code: String
        init(name: String) {
            self.name = name
            self.code = Lookup.Line.Code.by(name: name)
        }
    }
    let line: Line
    let departure: ExpectedTime
    let arrival: ExpectedTime
    let id: String
    init?(id: String, departure: String, arrival: String, delay delayString: String?, line: String, calendar: Calendar, baseDate: Date, baseComponents: DateComponents, baseTimeZone: TimeZone) {
        guard let depart = ExpectedTime(time: departure, delay: delayString, calendar: calendar, baseDate: baseDate, baseComponents: baseComponents, baseTimeZone: baseTimeZone) else {
            return nil
        }
        guard let arrive = ExpectedTime(time: arrival, delay: delayString, calendar: calendar, baseDate: baseDate, baseComponents: baseComponents, baseTimeZone: baseTimeZone) else {
            return nil
        }
        self.departure = depart
        self.arrival = arrive
        self.line = Line(name: line)
        self.id = id
    }
}


