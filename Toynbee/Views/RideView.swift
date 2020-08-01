import SwiftUI
struct RideView: View {
    var trip: Trip
    var body: some View {
        if let connection = trip.connection {
            VStack(alignment: .center, spacing: 4) {
                TrainView(train: trip.train)
                    .font(.footnote)
                Text("↓")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                Text(connection.name.uppercased())
                    .foregroundColor(.secondary)
                Text("↓")
                    .foregroundColor(.secondary)
                    .font(.caption2)
                TrainView(train: connection.train)
                    .font(.footnote)
            }
        } else {
            VStack(alignment: .center, spacing: 4) {
                Spacer()
                TrainView(train: trip.train)
                    .font(.footnote)
                Spacer()
            }
        }
    }
}
