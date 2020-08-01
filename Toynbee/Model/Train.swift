import Foundation

/// A given train trip - departure, arrival, time
struct Train {
    let line: Line
    let departure: ExpectedTime
    let arrival: ExpectedTime
    let id: String
    
    init?(id: String, departure: String, arrival: String, delay delayString: String?, line lineName: String, context: ExpectedTime.Context) {
        guard let depart = ExpectedTime(time: departure, delay: delayString, context: context) else {
            return nil
        }
        guard let arrive = ExpectedTime(time: arrival, delay: delayString, context: context) else {
            return nil
        }
        
        guard let line = Line.with(name: lineName) else {
            return nil
        }
        
        self.departure = depart
        self.arrival = arrive
        self.line = line
        self.id = id
    }
}


