import Foundation
import UIKit
import PinLayout

final class TemproaryViewController: UIViewController {
    let brandMarketHelperLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

    private func buildUI() {
        buildView()
        buildBrandMarketHelerLabel()
    }

    private func layoutUI() {
        layoutBrandMarketHelerLabel()
    }

    private func buildView() {
        view.backgroundColor = .white
    }

    private func buildBrandMarketHelerLabel() {
        brandMarketHelperLabel.text = "BrandMarketHelper"
        brandMarketHelperLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        brandMarketHelperLabel.textColor = .black
        brandMarketHelperLabel.textAlignment = .center
        brandMarketHelperLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brandMarketHelperLabel)
    }

    private func layoutBrandMarketHelerLabel() {
        let constraints = [
            brandMarketHelperLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            brandMarketHelperLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            brandMarketHelperLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 234
            ),
            brandMarketHelperLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -541
            ),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func animateText(completion: @escaping ((Bool) -> Void)) {
        let origin = self.brandMarketHelperLabel.frame.origin
        let size = self.brandMarketHelperLabel.frame.size
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			UIView.animate(withDuration: 1, animations: { [unowned self] in
				self.brandMarketHelperLabel.frame = CGRect(
					origin: CGPoint(
						x: origin.x,
						y: origin.y - 100
					),
					size: size
				)
			}, completion: completion)
		}
    }
}
