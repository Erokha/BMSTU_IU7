import Foundation

final class NewSupplyScreenInteractor {
	weak var output: NewSupplyScreenInteractorOutput?
    let service = BrandMarketAPIProvider.shared
}

extension NewSupplyScreenInteractor: NewSupplyScreenInteractorInput {
    func registerSupply(code: String, size: String, amount: String) {
        let model = SupplyDTOModel(
            code: code,
            size: size,
            amount: amount
        )
        service.sendNewSupply(with: model) { [weak self] response in
            switch response {
            case .success(_ ):
                self?.output?.handleSuccessSupplyResult()
            case .failure(let error):
                self?.output?.handleFailureSupplyResult(with: error.localizedDescription)
            }
        }
    }
    
    func searchProvidedSiezes(of code: String) {
        service.getProvdedSizes(of: code) { [weak self] response in
            switch response {
            case .success(let sizes):
                self?.output?.handleProvidesSizes(sizes)
            case .failure(let error):
                self?.output?.haldeProvidedSizesError(error)
            }
        }
    }
    
    
}
