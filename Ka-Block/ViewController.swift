import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var extensionEnabled = false {
        didSet {
            if extensionEnabled {
                self.label.text = "Ad blocking is enabled.\nYou’re all set!"
            } else {
                self.label.text = "Enable the Safari extension\nto prevent ads from appearing\non web pages."
            }
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
