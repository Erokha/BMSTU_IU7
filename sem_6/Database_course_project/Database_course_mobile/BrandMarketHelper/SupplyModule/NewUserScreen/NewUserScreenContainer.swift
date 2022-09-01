import UIKit

final class NewUserScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: NewUserScreenRouterInput!

	class func assemble(with context: NewUserScreenContext) -> NewUserScreenContainer {
        let router = NewUserScreenRouter()
        let interactor = NewUserScreenInteractor()
        let presenter = NewUserScreenPresenter(router: router, interactor: interactor)
		let viewController = NewUserScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return NewUserScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: NewUserScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct NewUserScreenContext {
}
