import UIKit

final class ProfileScreenRouter {
    weak var viewController: UIViewController?
}

extension ProfileScreenRouter: ProfileScreenRouterInput {
    func showError(with text: String) {
        let alert = UIAlertController(title: "Ooooops!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
    }
    
}
