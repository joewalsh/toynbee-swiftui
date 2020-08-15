import SwiftUI

struct ToynbeeView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        VStack {
            switch model.tripFetchState {
            case .fetching(let trips):
                StatusHeaderView(state: .busy)
                TripListView(trips: trips)
            case .empty:
                StatusHeaderView(state: .empty(message: "No Trips Found"))
                TripListView(trips: [])
            case .failure(let error):
                StatusHeaderView(state: .error(message: error.localizedDescription))
                TripListView(trips: [])
            case .success(let trips):
                StatusHeaderView(state: .success(headers: [Header(text: "Depart", id: 0), Header(text: "Ride", id: 1), Header(text: "Arrive", id: 2)]))
                TripListView(trips: trips)
            }
            OriginAndDestinationSelectionView()
        }
    }
}


struct ToynbeeView_Previews: PreviewProvider {
    static var previews: some View {
        ToynbeeView().environmentObject(ToynbeeModel.fixture)
        ToynbeeView().environmentObject(ToynbeeModel.errorFixture)
        ToynbeeView().environmentObject(ToynbeeModel.emptyFixture)
    }
}
