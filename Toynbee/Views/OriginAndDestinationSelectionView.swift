import SwiftUI

struct OriginAndDestinationSelectionView: View {
    @EnvironmentObject var model: ToynbeeModel
        
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            selectionView
        }.sheet(isPresented: $model.isSelectingStop) {
            StopListTableViewControllerWrapper(title: model.stopSelectionState == .origin ? "Select Departure" : "Select Arrival")
                .environmentObject(model)
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
    
}
