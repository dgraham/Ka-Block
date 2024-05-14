import SwiftUI

@main
struct KaBlockApp: App {
    @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "com.kablock.ios.KaBlockContentBlocker")

    #if os(macOS)
        @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif

    var body: some Scene {
        #if os(iOS)
            WindowGroup {
                HomeScreen(isEnabled: contentBlockerState.isEnabled)
            }
        #elseif os(macOS)
            WindowGroup {
                HomeScreen(isEnabled: contentBlockerState.isEnabled)
                    .frame(width: 375, height: 640)
                    .background(NonResizableWindow())
            }
            .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}

#if os(macOS)
    struct NonResizableWindow: NSViewRepresentable {
        func makeNSView(context _: Context) -> NSView {
            let view = NSView()
            DispatchQueue.main.async {
                guard let window = view.window else { return }
                window.styleMask = [.closable, .titled, .fullSizeContentView]
                window.collectionBehavior = [.fullScreenNone]

                if let menu = window.menu {
                    let appMenuItem = menu.item(withTitle: "Ka-Block!")!
                    let fileMenuItem = menu.item(withTitle: "File")!

                    menu.items = [appMenuItem, fileMenuItem]

                    appMenuItem.submenu!.items = [
                        appMenuItem.submenu!.item(withTitle: "About Ka-Block!")!,
                        NSMenuItem.separator(),
                        appMenuItem.submenu!.item(withTitle: "Quit Ka-Block!")!,
                    ]

                    fileMenuItem.submenu!.items = [
                        fileMenuItem.submenu!.item(withTitle: "Close")!,
                    ]
                }
            }
            return view
        }

        func updateNSView(_: NSView, context _: Context) {}
    }

    class AppDelegate: NSObject, NSApplicationDelegate {
        func applicationDidFinishLaunching(_: Notification) {
            NSWindow.allowsAutomaticWindowTabbing = false
        }

        func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
            true
        }
    }
#endif
