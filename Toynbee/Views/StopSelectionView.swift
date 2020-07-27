import SwiftUI

struct StopSelectionView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        Divider()
        selectionView
            .collapsed(model.isSelectingStop)
        stopListView
            .collapsed(!model.isSelectingStop)
    }
    
    var selectionView: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Button(action: {
                        withStopSelectionSheetAnimation {
                            model.selectOrigin()
                        }
                    }) {
                        Text("Depart")
                            .font(.headline)
                        Text(model.origin.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }.padding()
                HStack {
                    Button(action: {
                        withStopSelectionSheetAnimation {
                            model.selectDestination()
                        }
                    }) {
                        Text("Arrive")
                            .font(.headline)
                        Text(model.destination.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                }.padding()
            }
        }
    }
    
    let stopListView: some View = StopListView()
}
