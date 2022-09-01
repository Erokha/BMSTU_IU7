import UIKit

final class ShoppingBagScreenRouter {
    weak var viewController: UIViewController?
	weak var clientScreen: UIViewController?
}

extension ShoppingBagScreenRouter: ShoppingBagScreenRouterInput {
	func showError(message: String) {
		let alert = UIAlertController(title: "Ooooops...", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		viewController?.present(alert, animated: true)
	}
	
	func showNext() {
		guard let clientScreen = clientScreen else { return }
		clientScreen.modalPresentationStyle = .popover
		viewController?.present(clientScreen, animated: true, completion: nil)
	}
	
	func hideNext() {
		viewController?.dismiss(animated: true, completion: nil)
	}
	
}
