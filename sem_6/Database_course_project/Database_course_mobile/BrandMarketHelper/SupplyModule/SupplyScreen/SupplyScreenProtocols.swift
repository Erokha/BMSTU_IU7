import Foundation

protocol SupplyScreenViewInput: AnyObject {
    func updateUI()
}

protocol SupplyScreenViewOutput: AnyObject {
    func didTapNewSupplyButton()
    func didTapLogOutButton()
    func didLoadView()
    var viewModels: [SupplySelectorViewModel] { get }
}

protocol SupplyScreenInteractorInput: AnyObject {
    func checkPermissionAccess()
}

protocol SupplyScreenInteractorOutput: AnyObject {
    func handlePermissionAccess(acessLevel: BrandPermission)
}

protocol SupplyScreenRouterInput: AnyObject {
    func showNewSupplyScreen()
    func showNewEmployeeScreen()
}
