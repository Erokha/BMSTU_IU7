import Foundation

final class DetailScreenInteractor {
	weak var output: DetailScreenInteractorOutput?
	var shoppingBagService = ShoppingBagService.instance
    
    private func updateModel(model: DetailScreenModel) {
        output?.updateModel(with: model)
    }
}

extension DetailScreenInteractor: DetailScreenInteractorInput {
    func loadData(with code: String) {
        BrandMarketAPIProvider.shared.getModel(code: code) { [weak self] response in
			guard let self = self else { return }
            switch response {
            case .success(let model):
				let filledModel = self.fillModelWithShoppingBagContext(item: model)
                self.updateModel(model: filledModel)
            case .failure(let error):
                debugPrint("handling error \(error.localizedDescription)")
            }
        }
    }
	
	private func fillModelWithShoppingBagContext(item: DetailScreenModel) -> DetailScreenModel {
		let inShoppingBagItems = shoppingBagService
			.getItemsByCode(code: item.code)
			.filter { $0.count > 0 }
		
		var copy = item
		copy.sizes = item.sizes.map { copyItem in
			let matchingShoppingBagSize = inShoppingBagItems.first { $0.size == copyItem.size }
			if let bagSize = matchingShoppingBagSize {
				return DetailScreenStockSize(
					size: copyItem.size,
					amount: copyItem.amount,
					inShoppingBag: bagSize.count
				)
			}
			return copyItem
		}
		return copy
	}
	
	func addToShoppingBag(with model: ShoppingBagCellModel) {
		shoppingBagService.add(item: model)
	}
    
//    func sellItem(with code: String, size: String, amount: Int) {
//        let model = SupplyDTOModel(
//            code: code,
//            size: size,
//            amount: String(amount)
//        )
//        BrandMarketAPIProvider.shared.sellItem(with: model) { [weak self] result in
//            switch result {
//            case .success( _):
//                self?.output?.handleSuccessSell()
//            case .failure(let error):
//                self?.output?.handleFailureSell(with: error.localizedDescription)
//            }
//        }
//    }
    
}
