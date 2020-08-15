import SwiftUI

@main
struct ToynbeeApp: App {
    private var model = ToynbeeModel(initialTripFetchState: .empty)
    var body: some Scene {
        WindowGroup {
            ToynbeeView().environmentObject(model)
        }
    }
}
