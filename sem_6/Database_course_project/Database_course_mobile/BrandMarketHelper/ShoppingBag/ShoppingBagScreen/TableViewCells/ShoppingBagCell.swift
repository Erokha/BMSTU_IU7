import Foundation
import UIKit
import PinLayout


final class ShoppingBagTableViewCell: UITableViewCell {
	let imageProvider = BrandMarketImageProvider.shared
	public static let reuseIdentifier: String = "BrandMarket.ShoppingBagTableViewCell"
	var model: ShoppingBagCellModel? {
		didSet {
			guard let _ = self.model else { return }
			buildUI()
		}
	}
	let productNameLabel = UILabel()
	let productImageView = UIImageView()
	let productCountLabel = UILabel()
	let productSizeLabel = UILabel()
	
	override func prepareForReuse() {
		super.prepareForReuse()
		productNameLabel.removeFromSuperview()
		productImageView.removeFromSuperview()
		productCountLabel.removeFromSuperview()
	}
	
	private func buildUI() {
		self.selectionStyle = .none
		buildProductImageView()
		buildProductNameLabel()
		buildSizeLabel()
		buildCountLabel()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layoutProductImageView()
		layoutProductNameLabel()
		layoutSizeLabel()
		layoutCountLabel()
	}
	
}

extension ShoppingBagTableViewCell {
	
	private func buildProductImageView() {
		productImageView.contentMode = .scaleAspectFill
		imageProvider.getImage(
			url: model?.imageURL?.absoluteString,
			placeholder: nil,
			completion: { [weak self] response in
				switch response {
				case .success(let image):
					self?.productImageView.image = image
				case .failure( _):
					self?.productImageView.image = UIImage()
				}
		})
		contentView.addSubview(productImageView)
	}
	
	private func layoutProductImageView() {
		productImageView.pin
			.left(7)
			.height(70)
			.width(70)
			.vCenter(to: contentView.edge.vCenter)
		productImageView.clipsToBounds = true
		productImageView.layer.cornerRadius = 10
	}
	
	private func buildProductNameLabel() {
		productNameLabel.text = model?.name
		productNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		contentView.addSubview(productNameLabel)
	}
	
	private func layoutProductNameLabel() {
		productNameLabel.textAlignment = .left
		productNameLabel.pin
			.left(to: productImageView.edge.right).marginLeft(20)
			.right()
			.height(24)
			.vCenter(to: contentView.edge.vCenter).marginBottom(10)
	}
	
	private func buildSizeLabel() {
		productSizeLabel.text = "size: \(model?.size ?? "")"
		contentView.addSubview(productSizeLabel)
	}
	
	private func layoutSizeLabel() {
		productSizeLabel.pin
			.left(to: productImageView.edge.right).marginLeft(20)
			.width(60)
			.height(24)
			.top(to: productNameLabel.edge.bottom)
	}
	
	private func buildCountLabel() {
		productCountLabel.text = "amount: \(model?.count.description ?? "")"
		contentView.addSubview(productCountLabel)
	}
	
	private func layoutCountLabel() {
		productCountLabel.pin
			.left(to: productSizeLabel.edge.right).marginLeft(20)
			.right()
			.height(24)
			.top(to: productNameLabel.edge.bottom)
	}
	
	
}
