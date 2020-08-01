import Foundation
import Combine

struct Trip: Hashable {
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.train.departure.date == rhs.train.departure.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(train.departure.date)
    }
    
    let train: Train
    
    struct Connection {
        let train: Train
        let name: String
    }
    let connection: Connection?

    init?(json: TripJSON, context: ExpectedTime.Context) {
        guard let train = Train(id: json.orig_train, departure: json.orig_departure_time, arrival: json.orig_arrival_time, delay: json.orig_delay, line: json.orig_line, context: context) else {
            return nil
        }
        self.train = train
        if let termTrain = json.term_train,
           let termDepart = json.term_depart_time,
           let termArrive = json.term_arrival_time,
           let connectionStopName = json.Connection,
           let connectionLine = json.term_line,
           let connectingTrain = Train(id: termTrain, departure: termDepart, arrival: termArrive, delay: json.term_delay, line: connectionLine, context: context) {
            connection = Connection(train: connectingTrain, name: connectionStopName)
        } else {
            connection = nil
        }
    }
    
    var departure: ExpectedTime {
        return train.departure
    }
    
    var arrival: ExpectedTime {
        return connection?.train.arrival ?? train.arrival
    }
}
