import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var extensionEnabled = false {
        didSet {
            if extensionEnabled {
                self.label.text = "Enabled"
            } else {
                self.label.text = "Disabled"
            }
        }
    }
}
