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
    
    init?(id: String, departure: String, arrival: String, delay delayString: String?, line: String, context: ExpectedTime.Context) {
        guard let depart = ExpectedTime(time: departure, delay: delayString, context: context) else {
            return nil
        }
        guard let arrive = ExpectedTime(time: arrival, delay: delayString, context: context) else {
            return nil
        }
        self.departure = depart
        self.arrival = arrive
        self.line = Line(name: line)
        self.id = id
    }
}


