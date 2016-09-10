import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {
    func beginRequest(with context: NSExtensionContext) {
        let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "filters", withExtension: "json"))!

        let item = NSExtensionItem()
        item.attachments = [attachment]

        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
}
