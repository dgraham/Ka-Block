import Cocoa
import SafariServices

class ViewController: NSViewController {
    @IBOutlet weak var enabledLabel: NSTextField!
    @IBOutlet weak var disabledLabel: NSTextField!
    @IBOutlet weak var enabledImage: NSImageView!
    @IBOutlet weak var disabledImage: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: "com.kablock.macos.Ka-Block-Content-Blocker") {
            (state, error) in

            if let state = state {
                DispatchQueue.main.async {
                    let isEnabled = state.isEnabled
                    self.enabledLabel.isHidden = !isEnabled
                    self.disabledLabel.isHidden = isEnabled
                    self.enabledImage.isHidden = !isEnabled
                    self.disabledImage.isHidden = isEnabled
                }
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
