import Foundation
import Combine

enum APIError: Error {
    case generic
}

class API {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func make<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .eraseToAnyPublisher()
    }
    
    func getTrips(from origin: Stop, to destination: Stop) -> AnyPublisher<[Trip], Error> {
        guard let baseURL = URL(string: "https://www3.septa.org/hackathon/NextToArrive/") else {
            let subject = PassthroughSubject<[Trip], Error>()
            subject.send(completion: .failure(APIError.generic))
            return subject.eraseToAnyPublisher()
        }
        let nextToArriveURL = baseURL.appendingPathComponent(origin.param).appendingPathComponent(destination.param).appendingPathComponent("100")
        let context = ExpectedTime.Context()
        return make(URLRequest(url: nextToArriveURL))
            .map({ (response: Response<[TripJSON]>) -> [Trip] in
                response.value.compactMap {
                    Trip(json: $0, context: context)
                }
            })
            .eraseToAnyPublisher()
    }
}
