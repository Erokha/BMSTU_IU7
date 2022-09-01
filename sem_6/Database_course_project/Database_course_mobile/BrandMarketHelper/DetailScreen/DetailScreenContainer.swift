import UIKit

final class DetailScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: DetailScreenRouterInput!

	class func assemble(with context: DetailScreenContext) -> DetailScreenContainer {
        let router = DetailScreenRouter()
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter(router: router, interactor: interactor, code: context.itemCode)
		let viewController = DetailScreenViewController()
        
        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
		interactor.output = presenter

        return DetailScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: DetailScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct DetailScreenContext {
    let itemCode: String
}
