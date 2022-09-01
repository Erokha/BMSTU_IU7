import UIKit

final class AuthScreenRouter {
    weak var viewController: UIViewController?
}

extension AuthScreenRouter: AuthScreenRouterInput {
    func showError(with text: String) {
        let alert = UIAlertController(title: "Error", message: "Looks like username or password in incorrect", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
        NotificationCenter.default.post(.init(name: .brandMarketUpdateDetailScreen))
    }
    
    func showMainApp() {
        NotificationCenter.default.post(
            name: .brandMarketLogInSuccess,
            object: nil
        )
    }
    
}
