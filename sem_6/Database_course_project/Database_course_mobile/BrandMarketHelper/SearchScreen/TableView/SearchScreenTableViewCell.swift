import Foundation
import UIKit

struct SearchScreenCellModel {
    let imageURL: URL?
    let name: String
    let avaliable: Bool
    let price: Int
    
    init(from model: SearchScreenItemModel) {
        self.imageURL = model.imageURL
        self.name = "\(model.brand) \(model.itemName)"
        self.avaliable = model.avaliable
        self.price = model.price
    }
}

final class SearchScreenTableViewCell: UITableViewCell {
    let imageProvider = BrandMarketImageProvider.shared
    public static let reuseIdentifier: String = "BrandMarket.SearchScreenTableViewCell"
    var model: SearchScreenCellModel? {
        didSet {
            guard let _ = self.model else { return }
            buildUI()
        }
    }
    let productNameLabel = UILabel()
    let productImageView = UIImageView()
    let productAvaliableLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.removeFromSuperview()
        productImageView.removeFromSuperview()
        productAvaliableLabel.removeFromSuperview()
    }
    
    private func buildUI() {
        self.selectionStyle = .none
        buildProductImageView()
        buildProductNameLabel()
        buildAvaliableLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutProductImageView()
        layoutProductNameLabel()
        layoutAvaliableLabel()
    }
    
}

extension SearchScreenTableViewCell {
    
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
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            productImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 7),
            productImageView.heightAnchor.constraint(equalToConstant: 70),
            productImageView.widthAnchor.constraint(equalToConstant: 70),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildProductNameLabel() {
        productNameLabel.text = model?.name
        productNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        contentView.addSubview(productNameLabel)
    }
    
    private func layoutProductNameLabel() {
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.textAlignment = .left
        let constraints = [
            productNameLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 30),
            productNameLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -10),
            productNameLabel.heightAnchor.constraint(equalToConstant: 24),
            productNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildAvaliableLabel() {
        switch model?.avaliable {
        case .some(let avaliable):
            productAvaliableLabel.text = avaliable ? "Avaliable" : "Out of stock"
            productAvaliableLabel.textColor = avaliable ? .systemGreen : .systemRed
        case .none:
            productAvaliableLabel.text = ""
        }
        contentView.addSubview(productAvaliableLabel)
    }
    
    private func layoutAvaliableLabel() {
        productAvaliableLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            productAvaliableLabel.leftAnchor.constraint(equalTo: productNameLabel.leftAnchor),
            productAvaliableLabel.rightAnchor.constraint(equalTo: productNameLabel.rightAnchor),
            productAvaliableLabel.heightAnchor.constraint(equalToConstant: 24),
            productAvaliableLabel.topAnchor.constraint(equalTo: productNameLabel.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
