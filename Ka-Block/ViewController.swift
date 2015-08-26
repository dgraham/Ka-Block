import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
