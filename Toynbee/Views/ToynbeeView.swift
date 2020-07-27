import SwiftUI

struct ToynbeeView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        VStack {
            TripListView()
                .collapsed(model.isSelectingStop)
            OriginAndDestinationSelectionView()
        }
    }
}
