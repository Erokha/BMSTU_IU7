import UIKit

final class SupplyScreenRouter {
    weak var viewController: UIViewController?
}

extension SupplyScreenRouter: SupplyScreenRouterInput {
    func showNewSupplyScreen() {
        let vc = NewSupplyScreenContainer.assemble(
            with: NewSupplyScreenContext(
                code: ""
            )
        ).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNewEmployeeScreen() {
        let vc = NewUserScreenContainer.assemble(
            with: NewUserScreenContext()
        ).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
