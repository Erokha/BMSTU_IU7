import Foundation
import UIKit

public typealias closure = () -> Void

final class BrandGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping closure) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}

final class BrandGestureRecognizerFabric {
    static func gestureRecognizerOnEmptyTap(view: UIView?) {
        let gestureRecognizer = BrandGestureRecognizer { [weak view] in
            view?.endEditing(true)
        }
        view?.addGestureRecognizer(gestureRecognizer)
    }
}
