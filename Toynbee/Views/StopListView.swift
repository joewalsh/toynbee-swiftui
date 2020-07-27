import SwiftUI

struct StopListView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        VStack {
            header            
            StopListTableViewControllerWrapper()
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            Text(model.stopSelectionState == .origin ? "Select Departure" : "Select Arrival")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Button(action: {
                withStopSelectionSheetAnimation {
                    model.cancelStopSelection()
                }
            }) {
                Image("xmark")
            }
        }.padding([.leading, .top, .trailing])
    }
}


struct StopListView_Previews: PreviewProvider {
    static var previews: some View {
        StopListView()
    }
}
