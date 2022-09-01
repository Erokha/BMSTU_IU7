import Foundation

protocol ShoppingBagScreenViewInput: AnyObject {
	func updateTableView()
}

protocol ShoppingBagClientInfoViewInput: AnyObject {
	func startLoading()
	func loadSuccess()
	func loadFailed()
	func showError(with message: String)
}

protocol ShoppingBagScreenViewOutput: AnyObject {
	var items: [ShoppingBagCellModel] { get }
	func didTapNextButton()
	func didTapSellButton(with clientInfo: CustumerSerivceDTOItem)
	func removeFromShoppingBag(item: ShoppingBagCellModel)
}

protocol ShoppingBagScreenInteractorInput: AnyObject {
	func sell(items: [SupplyDTOModel], clientInfo: CustumerSerivceDTOItem)
	func removeFromCart(item: ShoppingBagCellModel)
}

protocol ShoppingBagScreenInteractorOutput: AnyObject {
	func handleSuccessSupply()
	func handleError(message: String?)
	func handleSuccsessRemovementFromCart()
	func handleSupplyFailure(message: String)
}

protocol ShoppingBagScreenRouterInput: AnyObject {
	func showNext()
	func hideNext()
	func showError(message: String)
}
