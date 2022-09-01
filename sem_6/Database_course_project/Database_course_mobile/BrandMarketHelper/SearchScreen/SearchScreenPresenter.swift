import Foundation

final class SearchScreenPresenter {
	weak var view: SearchScreenViewInput?
    var models: [SearchScreenItemModel] = [] {
        didSet {
            models.sort { ($0.brand + $0.itemName) < ($1.brand + $1.itemName) }
            DispatchQueue.main.async {
                self.view?.updateTableView()
            }
        }
    }

	private let router: SearchScreenRouterInput
	private let interactor: SearchScreenInteractorInput

    init(router: SearchScreenRouterInput, interactor: SearchScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchScreenPresenter: SearchScreenViewOutput {
	func onShoppingBagTap() {
		router.showShoppingBagTap()
	}
	
    func updateResults(with searchText: String) {
        interactor.searchProducts(searchInfo: searchText)
    }
    
    func didTapOnSection(section: Int) {
        let model = self.models[section]
        router.showDetailScreen(with: model.code)
    }
    
    func didLoadView() {
        interactor.searchProducts(searchInfo: "")
    }
	
	func refreshRequested() {
		BrandMarketImageProvider.shared.clearImageCache()
	}
}

extension SearchScreenPresenter: SearchScreenInteractorOutput {
    func failLoading() {
        self.view?.stopActivityAnimating()
    }
    
    func updateModel(with model: [SearchScreenItemModel]) {
        self.models = model
    }
    
}


