import SwiftUI

struct TripListView: View {
    @EnvironmentObject var model: ToynbeeModel
    
    var body: some View {
        VStack {
            header
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(model.trips, id: \.self) { value in
                        TripView(trip: value)
                        Divider()
                    }
                }
            }.onAppear {
                model.fetch()
            }
        }
    }
    
    var header: some View {
        HStack {
            if model.isBusy {
                ProgressView()
            } else if model.trips.isEmpty {
                Text("No Trips Found")
            } else {
                Text("Depart").bold()
                Spacer()
                Text("Ride").bold()
                Spacer()
                Text("Arrive").bold()
            }
        }.padding([.leading, .trailing, .top])
            .font(.headline)
            .foregroundColor(.secondary)
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
