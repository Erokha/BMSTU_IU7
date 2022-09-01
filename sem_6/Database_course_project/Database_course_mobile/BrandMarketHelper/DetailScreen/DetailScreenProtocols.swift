import Foundation

protocol DetailScreenViewInput: AnyObject {
    func updateUI()
}

protocol DetailScreenViewOutput: AnyObject {
    var model: DetailScreenModel? { get }
	var converter: DetailPresenterConverter { get }
    func didLoadView()
    func didTapBackButton()
    func didTapCodeLabel(with text: String)
    func handleSell(of size: DetailScreenStockSize)
    func didTapSupplyButton(code: String)
}

protocol DetailScreenInteractorInput: AnyObject {
    func loadData(with code: String)
    //func sellItem(with code: String, size: String, amount: Int)
	func addToShoppingBag(with model: ShoppingBagCellModel)
}

protocol DetailScreenInteractorOutput: AnyObject {
    func updateModel(with model: DetailScreenModel)
    func handleSuccessSell()
    func handleFailureSell(with errorDescription: String)
}

protocol DetailScreenRouterInput: AnyObject {
    func backToSearchScreen()
    func showSuccessAlert()
    func showFailureAlert(with errorDescription: String)
    func showSupplyOfThisProduct(code: String)
	func showAddToShoppingBagCountAlert(completion: @escaping ((Result<Int, BrandDetailRouterError>) -> Void))
}
