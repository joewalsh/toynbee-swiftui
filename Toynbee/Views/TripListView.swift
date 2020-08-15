import SwiftUI

struct TripListView: View {
    var trips: [Trip]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(trips, id: \.self) { value in
                    TripView(trip: value)
                    Divider()
                }
            }
        }
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView(trips: Trip.fixtures)
    }
}
