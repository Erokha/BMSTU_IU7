import UIKit

final class NewSupplyScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: NewSupplyScreenRouterInput!

	class func assemble(with context: NewSupplyScreenContext) -> NewSupplyScreenContainer {
        let router = NewSupplyScreenRouter()
        let interactor = NewSupplyScreenInteractor()
        let presenter = NewSupplyScreenPresenter(router: router, interactor: interactor)
		let viewController = NewSupplyScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter
        
        viewController.providedCode = context.code

        return NewSupplyScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: NewSupplyScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
    
}

struct NewSupplyScreenContext {
    let code: String
}
