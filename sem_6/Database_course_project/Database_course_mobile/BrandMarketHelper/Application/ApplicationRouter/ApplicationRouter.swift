import Foundation
import UIKit
import BrandMarketExtensions

enum AppBuildConfiguration {
    case production
    case mock
}

final class BrandUIWindow: UIWindow {
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		NotificationCenter.default.post(
			name: .brandMarketTraitCollectionDidChange,
			object: nil
		)
	}
}

final class ApplicationRouter {
    
    var window: BrandUIWindow?
    let tempViewController = TemproaryViewController()
    let configuration: AppBuildConfiguration
    let provider = BrandMarketAuthProvider.shared //MARK: Should be protocol, but i'm too lazy
    
    init(configuration: AppBuildConfiguration) {
        self.configuration = configuration
    }
    
    func startApp(scene: UIScene) {
        bindNotificationCenter()
        guard let scene = (scene as? UIWindowScene) else { return }
        window = BrandUIWindow(windowScene: scene)
        
        window?.rootViewController = tempViewController
        window?.makeKeyAndVisible()
        getInitialViewController { [unowned self] viewController in
            tempViewController.animateText() { _ in
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
            }
        }
    }
}

extension ApplicationRouter {
    private func getInitialViewController(
        completion: @escaping ((UIViewController) -> Void)
    ) {
        provider.checkSuccessValidateFromUserDefault { [unowned self] response in
            switch response {
            case true:
                completion(self.getTabBarController())
            case false:
                completion(self.getAuthController())
            }
            
        }
    }
    
    private func showMainScreen() {
        window?.rootViewController = getTabBarController()
    }
    
    private func showLoginScreen() {
        window?.rootViewController = getAuthController()
    }
    
    
    private func getAuthController() -> UIViewController {
        let container = AuthScreenContainer.assemble(with: AuthScreenContext())
        return wrapToNagivationController(container.viewController)
    }
    
    private func getTabBarController() -> UIViewController {
        let bar = UITabBarController()
        bar.tabBar.tintColor = .label
        bar.viewControllers = [
            prepareSearchScreen(),
            prepareSupplyScreen(),
            prepareProfileScreen(),
        ]
        return wrapToNagivationController(bar)
    }
    
    private func prepareSearchScreen() -> UIViewController {
        let container = SearchScreenContainer.assemble(
            with: SearchScreenContext(enviroment: self.configuration)
        )
        let viewController = container.viewController
        viewController.tabBarItem = .init(
            title: "Search",
            image: BrandImage.searchGlass.image,
            tag: 0
        )
        return wrapToNagivationController(viewController)
    }
    
    private func prepareSupplyScreen() -> UIViewController {
        let container = SupplyScreenContainer.assemble(
            with: SupplyScreenContext()
        )
        let viewController = container.viewController
        viewController.tabBarItem = .init(
            title: "Supply",
            image: BrandImage.box.image,
            tag: 1
        )
        return wrapToNagivationController(viewController)
    }
    
    private func prepareProfileScreen() -> UIViewController {
        let container = ProfileScreenContainer.assemble(
            with: ProfileScreenContext()
        )
        let viewController = container.viewController
        viewController.tabBarItem = .init(
            title: "Profile",
            image: BrandImage.person.image,
            tag: 2
        )
        return wrapToNagivationController(viewController)
    }
    
    private func bindNotificationCenter() {
        NotificationCenter.default.addObserver(
            forName: .brandMarketClearImageCache,
            object: nil,
            queue: .main,
            using: { _ in 
                BrandMarketImageProvider.shared.clearImageCache()
            }
        )
        NotificationCenter.default.addObserver(
            forName: .brandMarketLogInSuccess,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.showMainScreen()
            }
        )
        NotificationCenter.default.addObserver(
            forName: .brandMarketLogOut,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.showLoginScreen()
            }
        )
    }
    
    private func wrapToNagivationController(_ viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}

