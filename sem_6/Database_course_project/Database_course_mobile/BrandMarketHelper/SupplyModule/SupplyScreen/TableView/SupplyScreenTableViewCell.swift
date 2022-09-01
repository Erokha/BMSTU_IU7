import Foundation
import UIKit

struct SupplyScreenCellModel {
    let buttonText: String
    let completion: (() -> Void)
}

final class SupplyScreenTableViewCell: UITableViewCell {
    public static let reuseIdentifier: String = "BrandMarket.SupplyScreenTableViewCell"
    var model: SupplyScreenCellModel? {
        didSet {
            buildUI()
        }
    }
    
    @objc private func onButtonClick() {
        model?.completion()
    }
    
	var button = BrandButtonFactory.instance.defaultButton(title: nil)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.removeFromSuperview()
    }
    
    private func buildUI() {
        self.selectionStyle = .none
        buildButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutButton()
    }
    
}

extension SupplyScreenTableViewCell {
    
    private func buildButton() {
        button.setTitle(model?.buttonText, for: .normal)
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    private func layoutButton() {
        button.pin
            .all()
            .margin(5)
    }
}
