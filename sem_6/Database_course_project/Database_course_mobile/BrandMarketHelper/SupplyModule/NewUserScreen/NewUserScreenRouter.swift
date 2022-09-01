import UIKit

final class NewUserScreenRouter {
    weak var viewController: UIViewController?
}

extension NewUserScreenRouter: NewUserScreenRouterInput {
    func showError(with text: String) {
        let alert = UIAlertController(title: "Ooooops!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
        NotificationCenter.default.post(.init(name: .brandMarketUpdateDetailScreen))
    }
    
    func showUserInfo(user: BrandUserDTO) {
        let vc = RegisteredUserInfoViewController(with: user)
        vc.modalPresentationStyle = .popover
        viewController?.present(vc, animated: true, completion: nil)
    }
}
