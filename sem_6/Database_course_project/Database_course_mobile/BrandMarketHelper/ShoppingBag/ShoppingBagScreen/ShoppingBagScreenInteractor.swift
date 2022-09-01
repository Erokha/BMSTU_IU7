import Foundation

final class ShoppingBagScreenInteractor {
	weak var output: ShoppingBagScreenInteractorOutput?
	let apiProvider = BrandMarketAPIProvider.shared
	let bagService = ShoppingBagService.instance
}

extension ShoppingBagScreenInteractor: ShoppingBagScreenInteractorInput {
	func sell(
		items: [SupplyDTOModel],
		clientInfo: CustumerSerivceDTOItem
	) {
		apiProvider.sellMultiplyItems(
			with: items,
			customerServiceInfo: clientInfo,
			completion: { [weak self] result in
				switch result {
				case .success( _):
					self?.output?.handleSuccessSupply()
				case .failure(let error):
					self?.output?.handleSupplyFailure(message: "Unable to sell items. Error: \(error.localizedDescription)")
				}
			}
		)
	}
	
	func removeFromCart(item: ShoppingBagCellModel) {
		bagService.removePosition(item: item) { [weak self] _ in
			self?.output?.handleSuccsessRemovementFromCart()
		}
	}
}
