import Foundation

struct NewSupplyScreenSizesModel {
    let sizes: [String]
}

final class NewSupplyScreenPresenter {
    var model = NewSupplyScreenSizesModel(sizes: []) {
        didSet {
            view?.updatePickerData()
            guard model.sizes.count > 0
            else { return }
        }
    }
	weak var view: NewSupplyScreenViewInput?

	private let router: NewSupplyScreenRouterInput
	private let interactor: NewSupplyScreenInteractorInput

    init(router: NewSupplyScreenRouterInput, interactor: NewSupplyScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension NewSupplyScreenPresenter: NewSupplyScreenViewOutput {
	func didTapQRButton(with: ItemCodeInsertable) {
		router.showQRScanner(with: with)
	}
	
    func didTapSupplyButton(code: String, size: String, amount: String) {
        view?.disableSupplyButton()
        view?.startActivityAnimating()
        interactor.registerSupply(code: code, size: size, amount: amount)
    }
    
    func codeDidChanged(code: String) {
        interactor.searchProvidedSiezes(of: code)
    }
    
}

extension NewSupplyScreenPresenter: NewSupplyScreenInteractorOutput {
    func handleProvidesSizes(_ sizes: ProvidedSizes) {
        model = NewSupplyScreenSizesModel(sizes: sizes.sizes)
    }
    
    func haldeProvidedSizesError(_ error: BrandAPIError) {
        model = NewSupplyScreenSizesModel(sizes: [])
        
    }
    
    func handleSuccessSupplyResult() {
        router.showSuccessAlert()
        view?.stopActivityAnimating()
        view?.enableSupplyButton()
    }
    
    func handleFailureSupplyResult(with errorDescription: String) {
        router.showFailAlert()
        view?.stopActivityAnimating()
        view?.enableSupplyButton()
    }
    
}


