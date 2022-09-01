import UIKit

final class NewSupplyScreenRouter {
    weak var viewController: UIViewController?
}

extension NewSupplyScreenRouter: NewSupplyScreenRouterInput {
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Everything is done", message: "Supply registered!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
        NotificationCenter.default.post(.init(name: .brandMarketUpdateDetailScreen))
    }
    
    func showFailAlert() {
        let alert = UIAlertController(title: "Oooops", message: "Error happend! Check data and try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true)
    }
	
	func showQRScanner(with: ItemCodeInsertable) {
		let vc = ScannerViewController()
		vc.codeItemInsertable = with
		vc.modalPresentationStyle = .overFullScreen
		viewController?.navigationController?.pushViewController(vc, animated: true)
	}
}
