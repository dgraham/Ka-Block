import SafariServices
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var disabledLabel: UILabel!
    @IBOutlet weak var enabledLabel: UILabel!

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(checkEnabled), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        checkEnabled()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func checkEnabled() {
        if #available(iOS 10.0, *) {
            SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: "com.kablock.ios.Ka-Block-Content-Blocker", completionHandler: {
                (state, error) in
                
                if state != nil {
                    DispatchQueue.main.async {
                        self.enabledLabel.isHidden = !state!.isEnabled
                        self.disabledLabel.isHidden = state!.isEnabled
                    }
                }
            })
        } else {
            // Show settings hint on iOS 9.
            self.enabledLabel.isHidden = true
            self.disabledLabel.isHidden = false
        }
    }
}
