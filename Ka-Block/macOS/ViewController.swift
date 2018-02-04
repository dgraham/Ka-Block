import Cocoa
import SafariServices

class ViewController: NSViewController {
    @IBOutlet weak var enabledLabel: NSTextField!
    @IBOutlet weak var disabledLabel: NSTextField!
    @IBOutlet weak var enabledImage: NSImageView!
    @IBOutlet weak var disabledImage: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateContentBlockerState()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.updateContentBlockerState), userInfo: nil, repeats: true)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @objc func updateContentBlockerState() {
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
}
