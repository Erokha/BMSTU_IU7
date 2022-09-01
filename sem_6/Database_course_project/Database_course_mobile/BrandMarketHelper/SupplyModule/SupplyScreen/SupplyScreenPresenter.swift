import Foundation

struct SupplySelectorViewModel {
    let action: (() -> Void)
    let name: String
}

final class SupplyScreenPresenter {
    var permission: BrandPermission = .assistant
    
	weak var view: SupplyScreenViewInput?
	private let router: SupplyScreenRouterInput
	private let interactor: SupplyScreenInteractorInput

    init(router: SupplyScreenRouterInput, interactor: SupplyScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    var viewModels: [SupplySelectorViewModel] {
        var vm = [SupplySelectorViewModel]()
        vm.append(
            SupplySelectorViewModel(
                action: didTapNewSupplyButton,
                name: "New supply"
            )
        )
        
        if permission.accessLevel >= BrandPermission.manager.accessLevel {
            vm.append(
                SupplySelectorViewModel(
                    action: didTapNewProductButton,
                    name: "New product"
                )
            )
        }
        
        if permission.accessLevel >= BrandPermission.shopOwner.accessLevel {
            vm.append(
                SupplySelectorViewModel(
                    action: didTapNewEmployeeButton,
                    name: "New employee"
                )
            )
        }
        return vm
    }
}

extension SupplyScreenPresenter: SupplyScreenViewOutput {
    func didLoadView() {
        interactor.checkPermissionAccess()
    }
    
    func didTapNewSupplyButton() {
        router.showNewSupplyScreen()
    }
    
    func didTapLogOutButton() {
        BrandMarketAuthProvider.shared.logOut()
    }
    
    func didTapNewProductButton() {
        print("New Product not implemented yet")
    }
    
    func didTapNewEmployeeButton() {
        router.showNewEmployeeScreen()
    }
    
}

extension SupplyScreenPresenter: SupplyScreenInteractorOutput {
    func handlePermissionAccess(acessLevel: BrandPermission) {
        self.permission = acessLevel
        view?.updateUI()
    }
    
}


