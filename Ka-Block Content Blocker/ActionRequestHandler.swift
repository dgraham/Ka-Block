import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {
    func beginRequestWithExtensionContext(context: NSExtensionContext) {
        let attachment = NSItemProvider(contentsOfURL: NSBundle.mainBundle().URLForResource("filters", withExtension: "json"))!

        let item = NSExtensionItem()
        item.attachments = [attachment]

        context.completeRequestReturningItems([item], completionHandler: nil)
    }
}
