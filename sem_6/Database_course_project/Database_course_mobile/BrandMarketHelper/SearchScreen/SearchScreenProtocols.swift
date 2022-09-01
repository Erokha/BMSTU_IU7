import Foundation

protocol SearchScreenViewInput: AnyObject {
    func updateTableView()
    func stopActivityAnimating()
}

protocol SearchScreenViewOutput: AnyObject {
    var models: [SearchScreenItemModel] { get }
    func didLoadView()
    func didTapOnSection(section: Int)
    func updateResults(with searchText: String)
	func refreshRequested()
	func onShoppingBagTap()
}

protocol SearchScreenInteractorInput: AnyObject {
    var output: SearchScreenInteractorOutput? { get set }
    func searchProducts(searchInfo: String)
}

protocol SearchScreenInteractorOutput: AnyObject {
    func updateModel(with model: [SearchScreenItemModel])
    func failLoading()
}

protocol SearchScreenRouterInput: AnyObject {
    func showDetailScreen(with code: String)
	func showShoppingBagTap()
}
