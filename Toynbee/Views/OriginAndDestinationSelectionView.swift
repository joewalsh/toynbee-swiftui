import SwiftUI

struct OriginAndDestinationSelectionView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            selectionView
                .collapsed(model.isSelectingStop)
            stopListView
                .collapsed(!model.isSelectingStop)
        }
    }
    
    var selectionView: some View {
        VStack(alignment: .leading) {
            StopSelectionView(stop: model.origin, label: "Depart") {
                model.selectOrigin()
            }
            StopSelectionView(stop: model.destination, label: "Arrive") {
                model.selectDestination()
            }
        }
    }

    
    let stopListView: some View = StopListView()
}
