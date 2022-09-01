import UIKit
import PinLayout

enum DetailScreenState {
	case loading
	case loaded
}

final class DetailScreenViewController: UIViewController {
	var output: DetailScreenViewOutput?
    let productNamingLabel = UILabel()
    let codeLabel = UILabel()
    let sizesTitle = UILabel()
    let photoImageView = UIImageView()
    let sizesTableView = UITableView()
    let copiedView = CopiedToClipboardView()
    var backButton = UIButton(type: .system)
    let supplyButton = UIButton(type: .system)
	let priceLabel = UILabel()
	var state: DetailScreenState = .loading
	

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
        output?.didLoadView()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    private func buildUI() {
        buildView()
        buildBackButton()
        buildPhotoImageView()
        buildProductNamingLabel()
        buildSizesTitleLabel()
        buildSizesTableView()
		buildPriceLabel()
        buildCodeLabel()
        buildCopiedView()
        buildSupplyButton()
    }
    
    private func layoutUI() {
        layoutBackButton()
        layoutPhotoImageView()
        layoutProductNamingLabel()
        layoutSizesTitleLabel()
        layoutSizesTableView()
		layoutPriceLabel()
        layoutCodeLabel()
        layoutHiddenCopiedView()
        layoutSupplyButton()
    }
    
    @objc private func didTapBackButton() {
        output?.didTapBackButton()
    }
    
    @objc private func didSelectCodeLabel() {
        guard let codeText = codeLabel.text else { return }
        output?.didTapCodeLabel(with: codeText)
        showCopiedView()
    }
    
    @objc private func didTapSupplyButton() {
        guard let codeText = codeLabel.text else { return }
        output?.didTapSupplyButton(code: codeText)
    }
    
    private func showCopiedView() {
        view.layer.cornerRadius = 5
        copiedView.animateOnCopy()
    }
    
    private func didTapOnSell(of size: DetailScreenStockSize) {
        output?.handleSell(of: size)
    }
}

extension DetailScreenViewController {
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildBackButton() {
        backButton = BrandButtonFactory.instance.makeBackChevronButton(from: self)
        view.addSubview(backButton)
    }
    
    private func layoutBackButton() {
        backButton.pin
            .width(25)
            .height(40)
            .left(view.pin.safeArea).marginLeft(15)
            .top(view.pin.safeArea).marginTop(10)
    }
    
    private func buildPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 15
        view.addSubview(photoImageView)
    }
    
    private func layoutPhotoImageView() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.pin
            .left(20)
            .height(140)
            .below(of: backButton).marginTop(35)
            .width(140)
    }
    
    private func buildProductNamingLabel() {
        view.addSubview(productNamingLabel)
        productNamingLabel.textAlignment = .left
        productNamingLabel.numberOfLines = 0
        productNamingLabel.adjustsFontSizeToFitWidth = true
        productNamingLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private func layoutProductNamingLabel() {
        productNamingLabel.pin
            .left(to: photoImageView.edge.right).marginLeft(30)
            .right(20)
            .top(to: photoImageView.edge.top)
            .height(photoImageView.bounds.height * 0.5)
    }
    
    private func buildSizesTitleLabel() {
        sizesTitle.text = "Sizes"
        sizesTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        sizesTitle.textAlignment = .left
        view.addSubview(sizesTitle)
    }
    
    private func layoutSizesTitleLabel() {
        sizesTitle.pin
            .left(20)
            .right(20)
            .top(to: photoImageView.edge.bottom).marginTop(30)
            .height(23)
    }
    
    private func buildSizesTableView() {
        sizesTableView.largeContentTitle = "Sizes"
        sizesTableView.separatorStyle = .singleLine
        sizesTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: sizesTableView.frame.size.width, height: 0))
        sizesTableView.register(DetailScreenTableViewCell.self, forCellReuseIdentifier: DetailScreenTableViewCell.reuseIdentifier)
        sizesTableView.dataSource = self
        sizesTableView.delegate = self
        view.addSubview(sizesTableView)
    }
    
    private func layoutSizesTableView() {
        sizesTableView.pin
            .left(20)
            .right(20)
            .top(to: sizesTitle.edge.bottom)
            .bottom(5)
    }
    
    private func buildCodeLabel() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectCodeLabel))
        codeLabel.adjustsFontSizeToFitWidth = true
        codeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        codeLabel.textColor = .label
        codeLabel.isUserInteractionEnabled = true
        codeLabel.addGestureRecognizer(gestureRecognizer)
        view.addSubview(codeLabel)
    }
    
    private func layoutCodeLabel() {
        codeLabel.pin
			.top(to: priceLabel.edge.bottom).marginTop(5)
			.left(to: priceLabel.edge.left)
			.right()
            .height(photoImageView.bounds.height * 0.3)
    }
	
	private func buildPriceLabel() {
		if let price = output?.model?.price {
			priceLabel.text = "\(price.brandMoneyStyle)💸"
		}
		priceLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
		priceLabel.textAlignment = .right
		view.addSubview(priceLabel)
	}
	
	private func layoutPriceLabel() {
		priceLabel.pin
			.below(of: productNamingLabel).marginTop(10)
			.left(to: productNamingLabel.edge.left)
			.width(of: productNamingLabel)
			.height(20)
	}
    
    private func buildCopiedView() {
        copiedView.layer.shadowOffset = Constants.ShadowInfo.shadowOffset
        copiedView.layer.shadowOpacity = Constants.ShadowInfo.shadowOpacity
        copiedView.layer.shadowRadius = Constants.ShadowInfo.shadowRadius
        copiedView.layer.shadowColor = Constants.ShadowInfo.shadowColor
        view.addSubview(copiedView)
    }
    
    private func layoutHiddenCopiedView() {
        copiedView.layer.cornerRadius = 15
        copiedView.pin
            .hCenter()
            .top(-50)
            .height(50)
            .width(150)
    }
    
    private func buildSupplyButton() {
        supplyButton.setImage(BrandImage.box.image, for: .normal)
        supplyButton.tintColor = .label
        supplyButton.addTarget(self, action: #selector(didTapSupplyButton), for: .touchUpInside)
        view.addSubview(supplyButton)
    }
    
    private func layoutSupplyButton() {
        supplyButton.pin
            .width(25)
            .height(25)
            .right(view.pin.safeArea).marginRight(15)
            .top(view.pin.safeArea).marginTop(10)
    }
}

extension DetailScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard state == .loaded else {
			return 0
		}
        guard let count = output?.model?.sizes.count else { return 1 }
        return count > 0 ? count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = "Sizes"
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let output = output,
			  let cell = tableView.dequeueReusableCell(
                withIdentifier: DetailScreenTableViewCell.reuseIdentifier,
                for: indexPath) as? DetailScreenTableViewCell
        else {
            return UITableViewCell()
        }
		
        guard let sizes = output.model?.sizes,
              sizes.count > 0,
			  let model = output.model?.sizes[indexPath.row]
        else {
			cell.model = output.converter.StockSizeToCellModel(stickSize: nil)
            return cell
        }
		
		cell.model = output.converter.StockSizeToCellModel(stickSize: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        commonSwipeHandler(swipeFor: indexPath)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        commonSwipeHandler(swipeFor: indexPath)
    }
    
    private func commonSwipeHandler(swipeFor indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let model = output?.model,
			  indexPath.row < model.sizes.count,
			  model.sizes[indexPath.row].amount > 0
        else { return nil }
		let size = model.sizes[indexPath.row]
        let action = UIContextualAction(style: .normal,
                                        title: "Sell") { [weak self] _, _, completionHandler in
                                            self?.didTapOnSell(of: size)
                                            completionHandler(false)
        }
        action.backgroundColor = .systemIndigo
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}



extension DetailScreenViewController: DetailScreenViewInput {
    func updateUI() {
        guard let model = output?.model else {
            return
        }
		state = .loaded
		self.sizesTableView.reloadData()
        productNamingLabel.text = "\(model.type)\n\(model.brand)\n\(model.name)"
        codeLabel.text = output?.model?.code
        BrandMarketImageProvider.shared.getImage(
            url: model.imageURL,
            placeholder: nil) { [weak self] response in
            switch response {
            case .success(let image):
                self?.photoImageView.image = image
            case .failure( _): break
            }
        }
		priceLabel.text = "\(model.price.brandMoneyStyle)💸"
    }
}

extension DetailScreenViewController {
    private struct Constants {
        struct ShadowInfo {
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }
    }
}
