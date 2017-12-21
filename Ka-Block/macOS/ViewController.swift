import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var enabledLabel: NSTextField!
    @IBOutlet weak var disabledLabel: NSTextField!
    @IBOutlet weak var enabledImage: NSImageView!
    @IBOutlet weak var disabledImage: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let isEnabled = true
        self.enabledLabel.isHidden = !isEnabled
        self.disabledLabel.isHidden = isEnabled
        self.enabledImage.isHidden = !isEnabled
        self.disabledImage.isHidden = isEnabled
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
