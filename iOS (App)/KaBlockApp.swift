import SwiftUI

@main
struct KaBlockApp: App {
    @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "com.kablock.ios.KaBlockContentBlocker")

    var body: some Scene {
        WindowGroup {
            HomeScreen(isEnabled: contentBlockerState.isEnabled)
        }
    }
}
