import UIKit

final class SearchScreenContainer {
	let viewController: UIViewController
	private(set) weak var router: SearchScreenRouterInput!

	class func assemble(with context: SearchScreenContext) -> SearchScreenContainer {
        let router = SearchScreenRouter()
        let interactor: SearchScreenInteractorInput
        switch context.enviroment {
        case .mock:
            interactor = SearchScreenMockInteractor()
        case .production:
            interactor = SearchScreenInteractor()
        }
        let presenter = SearchScreenPresenter(router: router, interactor: interactor)
		let viewController = SearchScreenViewController()

        viewController.output = presenter
        router.viewController = viewController
		presenter.view = viewController
        interactor.output = presenter
		

        return SearchScreenContainer(view: viewController, router: router)
	}

    private init(view: UIViewController, router: SearchScreenRouterInput) {
		self.viewController = view
		self.router = router
	}
}

struct SearchScreenContext {
    let enviroment: AppBuildConfiguration
}
