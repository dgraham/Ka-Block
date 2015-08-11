import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

    var extensionEnabled = false {
        didSet {
            if let viewController = self.window?.rootViewController as? ViewController {
                viewController.extensionEnabled = extensionEnabled
            }
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        extensionEnabled = false
        SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.kablock.Ka-Block.Ka-Block-Content-Blocker") { error in
            dispatch_async(dispatch_get_main_queue()) {
                self.extensionEnabled = true
            }
        }
    }
}
