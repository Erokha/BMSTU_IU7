import UIKit

final class ProfileScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: ProfileScreenRouterInput!

	class func assemble(with context: ProfileScreenContext) -> ProfileScreenContainer {
        let router = ProfileScreenRouter()
        let interactor = ProfileScreenInteractor()
        let presenter = ProfileScreenPresenter(router: router, interactor: interactor)
		let viewController = ProfileScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return ProfileScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: ProfileScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct ProfileScreenContext {
}
