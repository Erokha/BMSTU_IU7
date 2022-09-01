import UIKit

final class ShoppingBagScreenContainer {
	let viewController: UIViewController
	let clientScreen: UIViewController
	
	private(set) weak var router: ShoppingBagScreenRouterInput!

	class func assemble(with context: ShoppingBagScreenContext) -> ShoppingBagScreenContainer {
        let router = ShoppingBagScreenRouter()
        let interactor = ShoppingBagScreenInteractor()
        let presenter = ShoppingBagScreenPresenter(router: router, interactor: interactor)
		let viewController = ShoppingBagScreenViewController()
		let clientScreen = ShoppingBagClientInfoScreen()

        viewController.output = presenter
		clientScreen.output = presenter
		
        router.viewController = viewController
		router.clientScreen = clientScreen
		
		presenter.view = viewController
		presenter.clientScreen = clientScreen
		
		interactor.output = presenter

        return ShoppingBagScreenContainer(view: viewController, clientScreen: clientScreen, router: router)
	}

	private init(view: UIViewController, clientScreen: UIViewController,  router: ShoppingBagScreenRouterInput) {
		self.viewController = view
		self.clientScreen = clientScreen
		self.router = router
	}
}

struct ShoppingBagScreenContext {
}
