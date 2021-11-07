import SafariServices

/// The state of a content blocker extension.
///
/// Wraps SFContentBlockerState as an ObservableObject.
class ContentBlockerState: ObservableObject {
    /// The bundle identifier of your content blocker extension.
    let identifier: String

    @Published private var state: Result<Bool, Error>? = nil

    private var notification: NSObjectProtocol?

    init(withIdentifier identifier: String) {
        self.identifier = identifier

        let notificationName: NSNotification.Name
        #if os(macOS)
            notificationName = NSWindow.didBecomeMainNotification
        #else
            notificationName = UIApplication.didBecomeActiveNotification
        #endif

        notification = NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: .main) { _ in
            self.refresh()
        }

        refresh()
    }

    deinit {
        if let observer = self.notification {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    /// A Boolean value that indicates whether the content blocker is enabled.
    var isEnabled: Bool {
        switch state {
        case let .success(isEnabled):
            return isEnabled
        case .failure, nil:
            return false
        }
    }

    func refresh() {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: identifier) { state, error in
            DispatchQueue.main.async {
                if let state = state {
                    self.state = .success(state.isEnabled)
                } else if let error = error {
                    self.state = .failure(error)
                } else {
                    self.state = nil
                }
            }
        }
    }
}
