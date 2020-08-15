import SwiftUI

struct ToynbeeView: View {
    @EnvironmentObject var model: ToynbeeModel
    var body: some View {
        VStack {
            StatusHeaderView(state: headerState)
            TripListView(trips: trips)
            OriginAndDestinationSelectionView()
        }
    }
    
    var headerState: StatusHeaderView.State {
        switch model.tripFetchState {
        case .fetching:
            return .busy
        case .empty:
            return .empty(message: "No Trips Found")
        case .failure(let error):
            return .error(message: error.localizedDescription)
        case .success:
            return .success(headers: [
                                Header(text: "Depart", id: 0),
                                Header(text: "Ride", id: 1),
                                Header(text: "Arrive", id: 2)
            ])
        }
    }
    
    var trips: [Trip] {
        switch model.tripFetchState {
        case .fetching(let trips):
            fallthrough
        case .success(let trips):
            return trips
        default:
            return []
        }
    }
}


struct ToynbeeView_Previews: PreviewProvider {
    static var previews: some View {
        ToynbeeView().environmentObject(ToynbeeModel.fixture)
        ToynbeeView().environmentObject(ToynbeeModel.errorFixture)
        ToynbeeView().environmentObject(ToynbeeModel.emptyFixture)
        ToynbeeView().environmentObject(ToynbeeModel.fixture)
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
    }
}
