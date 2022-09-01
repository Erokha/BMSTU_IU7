import UIKit

final class SearchScreenRouter {
    weak var viewController: UIViewController?
	var shoppingContainer: ShoppingBagScreenContainer? = nil
}

extension SearchScreenRouter: SearchScreenRouterInput {
	func showShoppingBagTap() {
		let container = ShoppingBagScreenContainer.assemble(
			with: ShoppingBagScreenContext()
		)
		let vc = container.viewController
		shoppingContainer = container
		viewController?.navigationController?.pushViewController(vc, animated: true)
	}
	
    func showDetailScreen(with code: String) {
        let vc = DetailScreenContainer.assemble(
            with: DetailScreenContext(itemCode: code)
        ).viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
