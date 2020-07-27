import SwiftUI

@main
struct ToynbeeApp: App {
    private var model = ToynbeeModel()
    var body: some Scene {
        WindowGroup {
            ToynbeeView().environmentObject(model)
        }
    }
}
