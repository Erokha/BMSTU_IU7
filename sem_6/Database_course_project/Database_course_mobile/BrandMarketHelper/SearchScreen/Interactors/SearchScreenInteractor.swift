import Foundation

final class SearchScreenInteractor {
    weak var output: SearchScreenInteractorOutput?
    
    private func updateModel(model: [SearchScreenItemModel]) {
        output?.updateModel(with: model)
    }
}



extension SearchScreenInteractor: SearchScreenInteractorInput {
    func searchProducts(searchInfo: String) {
        BrandMarketAPIProvider.shared.searchInDatabase(searchInfo: searchInfo) { [weak self] result in
            switch result {
            case .success(let model):
                self?.updateModel(model: model)
            case .failure(let error):
                self?.output?.failLoading()
            }
        }
    }
}


