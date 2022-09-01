import Foundation
import UIKit
import PinLayout


struct DetailScreenCellModel {
    let sizeTitle: String
    let inStock: Int
	let inShoppignBag: Int?
}

final class DetailScreenTableViewCell: UITableViewCell {
    let imageProvider = BrandMarketImageProvider.shared
    public static let reuseIdentifier: String = "BrandMarket.DetailScreenTableViewCell"
    var contentViewWidth: CGFloat {
        contentView.bounds.width
    }
    var model: DetailScreenCellModel? {
        didSet {
            guard let _ = self.model else { return }
            buildUI()
        }
    }
    let sizeTitleLabel = UILabel()
    let inStockLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sizeTitleLabel.removeFromSuperview()
        inStockLabel.removeFromSuperview()
    }
    
    private func buildUI() {
        self.selectionStyle = .none
        buildSizeTitleLabel()
        buildInStockLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSizeTitleLabel()
        layoutInStockLabel()
    }
    
}

extension DetailScreenTableViewCell {
    private func buildSizeTitleLabel() {
        contentView.addSubview(sizeTitleLabel)
        guard let model = self.model else { return }
        sizeTitleLabel.text = model.sizeTitle
        sizeTitleLabel.textAlignment = .left
        sizeTitleLabel.textColor = model.inStock > 0 ? .label : .systemRed
        sizeTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private func layoutSizeTitleLabel() {
		sizeTitleLabel.pin
			.left(20)
			.top(5)
			.bottom(-5)
			.right(to: self.edge.hCenter).marginRight(10%)
    }
    
    private func buildInStockLabel() {
        inStockLabel.textAlignment = .left
		inStockLabel.numberOfLines = 0
        inStockLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(inStockLabel)
        guard let inStock = model?.inStock else { return }
		var text: String = inStock > 0 ? "in stock: \(inStock)" : ""
		if let inShoppingBag = model?.inShoppignBag {
			text += "\nin bag: \(inShoppingBag)"
		}
		inStockLabel.text = text
    }
    
    private func layoutInStockLabel() {
		inStockLabel.pin
			.left(to: sizeTitleLabel.edge.right).marginLeft(10)
			.top(5)
			.bottom(-5)
			.right()
    }
    
}
