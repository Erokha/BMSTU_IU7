import UIKit
import PinLayout



final class ShoppingBagScreenViewController: UIViewController {
	var output: ShoppingBagScreenViewOutput?
	var backButton = UIButton()
	let tableView = UITableView()
	var sellButton = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layoutUI()
	}
	
	@objc private func didTapSellButton() {
		output?.didTapNextButton()
	}
	
}

extension ShoppingBagScreenViewController {
	func setupUI() {
		setupView()
		setupBackButton()
		setupTableView()
		setupSellButton()
	}
	
	func layoutUI() {
		layoutBackButton()
		layoutTableView()
		layoutSellButton()
	}
	
	func setupView() {
		view.backgroundColor = .systemBackground
	}
	
	func setupBackButton() {
		backButton = BrandButtonFactory.instance.makeBackChevronButton(from: self)
		view.addSubview(backButton)
	}
	
	func layoutBackButton() {
		backButton.pin
			.width(25)
			.height(25)
			.left(view.pin.safeArea).marginLeft(15)
			.top(view.pin.safeArea).marginTop(10)
	}
	
	func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(ShoppingBagTableViewCell.self, forCellReuseIdentifier: ShoppingBagTableViewCell.reuseIdentifier)
		view.addSubview(tableView)
	}
	
	func layoutTableView() {
		tableView.clipsToBounds = true
		tableView.separatorStyle = .none
		tableView.pin
			.top(to: backButton.edge.bottom).marginTop(10)
			.left()
			.right()
			.bottom(view.pin.safeArea).marginBottom(70)
	}
	
	func setupSellButton() {
		sellButton = BrandButtonFactory.instance.defaultButton(title: totalText)
		view.addSubview(sellButton)
		sellButton.addTarget(self, action: #selector(didTapSellButton), for: .touchUpInside)
	}
	
	func layoutSellButton() {
		sellButton.pin
			.left(30)
			.right(30)
			.height(40)
			.top(to: tableView.edge.bottom).marginTop(10)
	}
	
	private var totalText: String {
		guard let output = output else { return "Total: 🤔"}
		return "Total: \(output.items.map { $0.price * $0.count }.reduce(0, +))"
	}
}

extension ShoppingBagScreenViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return output?.items.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 85
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: ShoppingBagTableViewCell.reuseIdentifier,
				for: indexPath) as? ShoppingBagTableViewCell,
			  let model = output?.items[indexPath.row]
		else {
			return UITableViewCell()
		}
		cell.model = model
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		commonSwipeHandler(swipeFor: indexPath)
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		commonSwipeHandler(swipeFor: indexPath)
	}
	
	private func commonSwipeHandler(swipeFor indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		guard let outputModels = output?.items,
			  indexPath.row < outputModels.count,
			  let item = output?.items[indexPath.row]
		else { return nil }
		let action = UIContextualAction(style: .normal,
										title: "Remove from cart") { [weak self] _, _, completionHandler in
			self?.output?.removeFromShoppingBag(item: item)
			completionHandler(false)
		}
		action.backgroundColor = .systemRed
		return UISwipeActionsConfiguration(actions: [action])
	}
	
}


extension ShoppingBagScreenViewController: ShoppingBagScreenViewInput {
	func updateTableView() {
		tableView.reloadData()
		sellButton.setTitle(totalText, for: .normal)
	}
}
