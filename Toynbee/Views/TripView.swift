import SwiftUI

struct TripView: View {
    var trip: Trip
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(trip.departure.date, style: .time)
                        .font(.title2)
                        .padding(.bottom, 4)  // is there a dynamic value that could be used?
                    
                    if let delayInMinutes = trip.departure.delay.minute, delayInMinutes > 0 {
                        Text("\(delayInMinutes) LATE").foregroundColor(.red).font(.subheadline).bold()
                    } else {
                        Text("On time").foregroundColor(.secondary).font(.subheadline)
                    }
                }
                Spacer()
                RideView(trip: trip)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(trip.arrival.date, style: .time)
                        .font(.title2)
                    Spacer()
                }
            }.padding(.bottom, 4)
           
        }.padding([.leading, .trailing])
    }
   
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(trip: Trip.fixtures[0])
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
        TripView(trip: Trip.fixtures[1])
    }
}
