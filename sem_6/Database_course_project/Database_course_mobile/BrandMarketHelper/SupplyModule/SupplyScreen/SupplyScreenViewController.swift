import UIKit
import PinLayout

final class SupplyScreenViewController: UIViewController {
	var output: SupplyScreenViewOutput?
    private let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
        output?.didLoadView()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    enum SupplySections: Int, CaseIterable {
        case newSupply
        case logOut
    }
}

extension SupplyScreenViewController {
    private func buildUI() {
        buildView()
        buildTableView()
        buildGestureRecognizer()
    }
    
    private func layoutUI() {
        layoutTableView()
    }
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = true
        tableView.register(SupplyScreenTableViewCell.self, forCellReuseIdentifier: SupplyScreenTableViewCell.reuseIdentifier)
        view.addSubview(tableView)
    }
    
    private func layoutTableView() {
        tableView.pin
            .all(view.pin.safeArea)
            .marginLeft(20)
            .marginRight(20)
    }
    
    private func buildGestureRecognizer() {
        BrandGestureRecognizerFabric.gestureRecognizerOnEmptyTap(view: self.view)
    }
}

extension SupplyScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.viewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SupplyScreenTableViewCell.reuseIdentifier, for: indexPath)
            as? SupplyScreenTableViewCell else { return UITableViewCell() }
        guard let viewModel = output?.viewModels[indexPath.row] else { return UITableViewCell() }
        cell.model = SupplyScreenCellModel(
            buttonText: viewModel.name,
            completion: viewModel.action
        )
        return cell
    }
    
}

extension SupplyScreenViewController: SupplyScreenViewInput {
    func updateUI() {
        tableView.reloadData()
    }
    
}
