import UIKit

final class AuthScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: AuthScreenRouterInput!

	class func assemble(with context: AuthScreenContext) -> AuthScreenContainer {
        let router = AuthScreenRouter()
        let interactor = AuthScreenInteractor()
        let presenter = AuthScreenPresenter(router: router, interactor: interactor)
		let viewController = AuthScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return AuthScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: AuthScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct AuthScreenContext {
}
