import SwiftUI

@main
struct KaBlockApp: App {
    @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "com.kablock.ios.KaBlockContentBlocker")

    var body: some Scene {
        WindowGroup {
            HomeScreen(isEnabled: contentBlockerState.isEnabled)
            #if os(macOS)
                .frame(width: 375, height: 640)
            #endif
        }
        #if os(macOS)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
