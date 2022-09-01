import Foundation

protocol NewSupplyScreenViewInput: AnyObject {
    func updatePickerData()
    func startActivityAnimating()
    func stopActivityAnimating()
    func disableSupplyButton()
    func enableSupplyButton()
}

protocol NewSupplyScreenViewOutput: AnyObject {
    var model: NewSupplyScreenSizesModel { get }
    func codeDidChanged(code: String)
    func didTapSupplyButton(code: String, size: String, amount: String)
	func didTapQRButton(with: ItemCodeInsertable)
}

protocol NewSupplyScreenInteractorInput: AnyObject {
    func searchProvidedSiezes(of code: String)
    func registerSupply(code: String, size: String, amount: String)
}

protocol NewSupplyScreenInteractorOutput: AnyObject {
    func handleProvidesSizes(_ sizes: ProvidedSizes)
    func haldeProvidedSizesError(_ error: BrandAPIError)
    func handleSuccessSupplyResult()
    func handleFailureSupplyResult(with errorDescription: String)
}

protocol NewSupplyScreenRouterInput: AnyObject {
    func showSuccessAlert()
    func showFailAlert()
	func showQRScanner(with: ItemCodeInsertable)
}
