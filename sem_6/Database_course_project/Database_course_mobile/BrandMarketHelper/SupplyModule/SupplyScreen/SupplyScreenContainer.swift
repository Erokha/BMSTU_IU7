import UIKit

final class SupplyScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: SupplyScreenRouterInput!

	class func assemble(with context: SupplyScreenContext) -> SupplyScreenContainer {
        let router = SupplyScreenRouter()
        let interactor = SupplyScreenInteractor()
        let presenter = SupplyScreenPresenter(router: router, interactor: interactor)
		let viewController = SupplyScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return SupplyScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: SupplyScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct SupplyScreenContext {
}
