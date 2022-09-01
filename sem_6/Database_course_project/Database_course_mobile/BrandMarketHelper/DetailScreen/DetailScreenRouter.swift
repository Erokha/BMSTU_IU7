import UIKit

enum BrandDetailRouterError: Error {
	case unknownError
	case unableToParseInt
}

final class DetailScreenRouter {
    weak var viewController: UIViewController?
}

extension DetailScreenRouter: DetailScreenRouterInput {
    func showSupplyOfThisProduct(code: String) {
        let container = NewSupplyScreenContainer.assemble(
            with: NewSupplyScreenContext(
                code: code
            )
        )
        let vc = container.viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Everything is done", message: "Added to shopping bag!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            NotificationCenter.default.post(.init(name: .brandMarketUpdateDetailScreen))
        }))
        self.viewController?.present(alert, animated: true)
    }
    
    func showFailureAlert(with errorDescription: String) {
        let alert = UIAlertController(title: "Ooooops...", message: "Something went wrong. Check data and try again!\nDescription:\(errorDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
    }
    
    func backToSearchScreen() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
	func showAddToShoppingBagCountAlert(
		completion: @escaping ((Result<Int, BrandDetailRouterError>) -> Void)
	) {
		let alert = UIAlertController(
			title: "Add to shopping bag",
			message: "Number of items to add to shopping bag",
			preferredStyle: .alert
		)
		
		alert.addTextField { (textField) in
			textField.text = "1"
		}
		
		let action = UIAlertAction(title: "OK", style: .default) { [weak alert] _ in
			guard let text = alert?.textFields?[0].text else {
			   completion(.failure(.unknownError))
			   return
			}
		   
		   guard let numberOfItems = Int(text) else {
			   completion(.failure(.unableToParseInt))
			   return
		   }
		   completion(.success(numberOfItems))
	   }

		alert.addAction(action)

		self.viewController?.present(alert, animated: true)
	}
}
