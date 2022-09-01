import Foundation
import UIKit

struct DetailPresenterConverter {
	func StockSizeToCellModel(
		stickSize: DetailScreenStockSize?
	) -> DetailScreenCellModel {
		guard let model = stickSize else {
			return DetailScreenCellModel(sizeTitle: "Out of stock", inStock: -1, inShoppignBag: nil)
		}
		return DetailScreenCellModel(sizeTitle: model.size, inStock: model.amount, inShoppignBag: model.inShoppingBag)
	}
}

final class DetailScreenPresenter {
	weak var view: DetailScreenViewInput?
    let productCode: String
    
    private var _model: DetailScreenModel?
	
	public let converter = DetailPresenterConverter()
    var model: DetailScreenModel? {
        set {
            var copy = newValue
            copy?.sizes = newValue?.sizes.filter{ $0.amount > 0} ?? []
            _model = copy
            _model?.sizes.sort { $0.size < $1.size }
            _model = model
            view?.updateUI()
        }
        get {
            return _model
        }
        
    }
    
	private let router: DetailScreenRouterInput
	private let interactor: DetailScreenInteractorInput

    init(router: DetailScreenRouterInput, interactor: DetailScreenInteractorInput, code: String) {
        self.router = router
        self.interactor = interactor
        self.productCode = code
        NotificationCenter.default.addObserver(
            forName: .brandMarketUpdateDetailScreen,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                interactor.loadData(with: self.productCode)
            }
        )
    }
    
    
}

extension DetailScreenPresenter: DetailScreenViewOutput {
    func didTapSupplyButton(code: String) {
        router.showSupplyOfThisProduct(code: code)
    }
    
    func handleSell(of size: DetailScreenStockSize) {
        guard let model = model else {
            router.showFailureAlert(with: "Internal error")
            return
        }
		router.showAddToShoppingBagCountAlert() { [weak self] result in
			switch result {
			case .success(let numberOfItems):
				let contextedSize = DetailScreenStockSize(
					size: size.size,
					amount: numberOfItems,
					inShoppingBag: size.inShoppingBag
				)
				self?.handleSuccessAddToShoppingBag(size: contextedSize, model: model)
			case .failure(let error):
				self?.handleFailureAddToShoppingBag(reason: error) { [weak self] in
					self?.handleSell(of: size)
				}
				
			}
		}
		//interactor.sellItem(with: model.code, size: size.size, amount: 1)
    }
	
	private func handleSuccessAddToShoppingBag(size: DetailScreenStockSize, model: DetailScreenModel) {
		guard let stockModel = model.sizes.first(where: { $0.size == size.size }),
			  size.amount + (size.inShoppingBag ?? 0) <= stockModel.amount
		else {
			router.showFailureAlert(with: "We do not have that much items")
			return
		}
		let bagModel = ShoppingBagCellModel(
			imageURL: URL(string: model.imageURL ?? ""),
			name: model.name,
			code: model.code,
			size: size.size,
			count: size.amount,
			price: model.price
		)
		interactor.addToShoppingBag(with: bagModel)
		router.showSuccessAlert()
	}
	
	private func handleFailureAddToShoppingBag(
		reason: BrandDetailRouterError,
		retryClosure: (() -> Void)?
	) {
		switch reason {
		case .unknownError:
			router.showFailureAlert(with: "Internal error... :(")
		case .unableToParseInt:
			router.showFailureAlert(with: "Please, enter integer number!")
			retryClosure?()
		}
	}
    
    func didTapCodeLabel(with text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
    
    func didLoadView() {
        interactor.loadData(with: productCode)
    }
    
    func didTapBackButton() {
        router.backToSearchScreen()
    }
    
}

extension DetailScreenPresenter: DetailScreenInteractorOutput {
    func handleSuccessSell() {
        router.showSuccessAlert()
    }
    
    func handleFailureSell(with errorDescription: String) {
        router.showFailureAlert(with: errorDescription)
    }
    
    func updateModel(with model: DetailScreenModel) {
        self.model = model
    }
}


