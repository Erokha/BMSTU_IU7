import Foundation
import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        @objc class ClosureSleeve: NSObject {
            let closure:()->()
            init(_ closure: @escaping()->()) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

final class BrandButtonFactory {
	
	static let instance = BrandButtonFactory()
	
	private init() {
		NotificationCenter.default.addObserver(
			forName: .brandMarketTraitCollectionDidChange,
			object: nil,
			queue: .main,
			using: { [weak self] _ in
				self?.traitCollectionDidChange()
			})
	}
	
	var defaultButtons: NSHashTable<UIButton> = .weakObjects()
	
	
	
	func traitCollectionDidChange() {
		defaultButtons.allObjects.forEach { button in
			switch UITraitCollection.current.userInterfaceStyle {
			case .dark:
				button.backgroundColor = .white
				button.setTitleColor(.black, for: .normal)
			default:
				button.backgroundColor = .black
				button.setTitleColor(.white, for: .normal)
			}
		}
	}
    
	func makeBackChevronButton(
        from viewController: UIViewController
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(BrandImage.chevronLeft.image, for: .normal)
        button.tintColor = .label
        button.addAction { [weak viewController] in
            viewController?.navigationController?.popViewController(animated: true)
        }
        return button
    }
    
	func makeQrCodeButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(BrandImage.qrcode.image, for: .normal)
        button.tintColor = .label
        return button
    }
	
	func defaultButton(title: String?) -> UIButton {
		let button = UIButton(type: .system)
		switch UITraitCollection.current.userInterfaceStyle {
		case .dark:
			button.backgroundColor = .white
			button.setTitleColor(.black, for: .normal)
		default:
			button.backgroundColor = .black
			button.setTitleColor(.white, for: .normal)
		}
		button.setTitle(title, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		button.isUserInteractionEnabled = true
		defaultButtons.add(button)
		return button
	}
}
