import SwiftUI

struct Header: Identifiable {
    let text: String
    let id: Int
}
struct StatusHeaderView: View {
    enum State {
        case busy
        case empty(message: String)
        case error(message: String)
        case success(headers: [Header])
    }
    var state: State
    
    var body: some View {
        HStack {
            switch state {
            case .busy:
                ProgressView()
            case .error(let message):
                Text(message)
            case .empty(let message):
                Text(message)
            case .success(let headers):
                ForEach(headers) { header in
                    Text(header.text)
                    if header.id != headers.last?.id {
                        Spacer()
                    }
                }
            }
        }.padding([.leading, .trailing, .top])
        .font(.headline)
        .foregroundColor(.secondary)
    }
}
