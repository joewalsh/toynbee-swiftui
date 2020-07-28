import SwiftUI

struct StopSelectionView: View {
    let stop: Stop
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.headline)
            Text(stop.name)
                .font(.headline)
                .foregroundColor(.primary)
        }.padding()
    }
}
