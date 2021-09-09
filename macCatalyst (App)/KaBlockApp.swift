import SwiftUI

@main
struct KaBlockApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    @ObservedObject var contentBlockerState = ContentBlockerState(withIdentifier: "com.kablock.ios.KaBlockContentBlocker")

    var body: some Scene {
        WindowGroup {
            HomeScreen(isEnabled: contentBlockerState.isEnabled)
                .background(NonResizableWindow())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)

        guard builder.system == UIMenuSystem.main else { return }

        builder.remove(menu: .services)
        builder.remove(menu: .hide)
        builder.remove(menu: .edit)
        builder.remove(menu: .format)
        builder.remove(menu: .view)
        builder.remove(menu: .window)
        builder.remove(menu: .help)
    }
}

struct NonResizableWindow: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            guard let window = view.window else { return }

            if let sizeRestrictions = window.windowScene?.sizeRestrictions {
                let size = CGSize(width: 375, height: 640)
                sizeRestrictions.minimumSize = size
                sizeRestrictions.maximumSize = size
            }

            if let titlebar = window.windowScene?.titlebar {
                titlebar.titleVisibility = .hidden
                titlebar.toolbar = nil
            }

            let nsWindow = window.nsWindow
            nsWindow.setValue(0x100003, forKey: "styleMask")
            nsWindow.setValue(0x1000, forKey: "collectionBehavior")
        }
        return view
    }

    func updateUIView(_: UIView, context _: Context) {}
}

extension UIWindow {
    // See Dynamic library for reference.
    // https://github.com/mhdhejazi/Dynamic#1-get-the-nswindow-from-a-uiwindow-in-a-maccatalyst-app
    var nsWindow: AnyObject {
        let nsApplication /*: NSApplication */ = NSClassFromString("NSApplication")!.value(forKeyPath: "sharedApplication") as AnyObject
        let nsApplicationDelegate /*: UINSApplicationDelegate */ = nsApplication.value(forKeyPath: "delegate") as AnyObject
        let nsWindowProxy /*: UINSWindowProxy */ = nsApplicationDelegate.perform(NSSelectorFromString("hostWindowForUIWindow:"), with: self).takeRetainedValue() as AnyObject
        let nsWindow /*: UINSWindow */ = nsWindowProxy.value(forKeyPath: "attachedWindow") as AnyObject
        return nsWindow
    }
}
