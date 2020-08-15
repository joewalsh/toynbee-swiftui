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
    let state: State
    
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
                let lastID = headers.last?.id
                ForEach(headers) { header in
                    Text(header.text)
                    if header.id != lastID {
                        Spacer()
                    }
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .font(.headline)
        .foregroundColor(.secondary)
    }
}
