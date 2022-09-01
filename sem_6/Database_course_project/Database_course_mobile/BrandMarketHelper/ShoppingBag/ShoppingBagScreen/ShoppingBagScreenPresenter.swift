import Foundation

final class ShoppingBagScreenPresenter {
	weak var view: ShoppingBagScreenViewInput?
	weak var clientScreen: ShoppingBagClientInfoViewInput?
	var shoppingBagService = ShoppingBagService.instance

	private let router: ShoppingBagScreenRouterInput
	private let interactor: ShoppingBagScreenInteractorInput
	
	var items: [ShoppingBagCellModel] {
		shoppingBagService.items
	}

    init(router: ShoppingBagScreenRouterInput, interactor: ShoppingBagScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ShoppingBagScreenPresenter: ShoppingBagScreenViewOutput {
	func removeFromShoppingBag(item: ShoppingBagCellModel) {
		interactor.removeFromCart(item: item)
		view?.updateTableView()
	}
	
	func didTapNextButton() {
		guard items.count > 0 else {
			router.showError(message: "You have no items in cart")
			return
		}
		router.showNext()
	}
	
	func didTapSellButton(with clientInfo: CustumerSerivceDTOItem) {
		let dtoItems = items.map { SupplyDTOModel(code: $0.code, size: $0.size, amount: String($0.count) )}
		clientScreen?.startLoading()
		interactor.sell(items: dtoItems, clientInfo: clientInfo)
	}
}

extension ShoppingBagScreenPresenter: ShoppingBagScreenInteractorOutput {
	func handleSuccessSupply() {
		shoppingBagService.handle_success_supply()
		clientScreen?.loadSuccess()
		router.hideNext()
		view?.updateTableView()
	}
	
	func handleSupplyFailure(message: String) {
		clientScreen?.loadFailed()
		clientScreen?.showError(with: message)
	}
	
	func handleError(message: String?) {
		debugPrint(message)
	}
	
	func handleSuccsessRemovementFromCart() {
		view?.updateTableView()
	}
}


