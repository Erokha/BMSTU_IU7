import UIKit

final class SearchScreenViewController: UIViewController {
	var output: SearchScreenViewOutput?
    let searchBar = UISearchBar()
    let shoppingBagButton = UIButton()
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
        output?.didLoadView() 
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    @objc private func handleNewSearchText() {
        output?.updateResults(with: searchBar.text ?? "")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    
    @objc private func pullToRefresh() {
		output?.refreshRequested()
        output?.updateResults(with: self.searchBar.text ?? "")
    }
	
	@objc private func onShoppingBagTap() {
		output?.onShoppingBagTap()
	}
	
}

extension SearchScreenViewController {
    private func buildUI() {
        buildView()
        buildShoppingBagButton()
        buildSearchBar()
        buildTableView()
    }
    
    private func layoutUI() {
        layoutSearchBar()
        layoutShoppingBagButton()
        layoutTableView()
    }
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildShoppingBagButton() {
		let image = BrandImage.shoppingBag.image
		shoppingBagButton.setImage(image, for: .normal)
		shoppingBagButton.tintColor = .white
		shoppingBagButton.addTarget(self, action: #selector(onShoppingBagTap), for: .touchUpInside)
        view.addSubview(shoppingBagButton)
    }
    
    private func layoutShoppingBagButton() {
        shoppingBagButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            shoppingBagButton.widthAnchor.constraint(equalToConstant: 35),
            shoppingBagButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            shoppingBagButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            shoppingBagButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    private func layoutSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            searchBar.rightAnchor.constraint(equalTo: shoppingBagButton.leftAnchor, constant: -5),
            searchBar.centerYAnchor.constraint(equalTo: shoppingBagButton.centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 35)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self
		tableView.backgroundColor = .systemBackground
        tableView.register(SearchScreenTableViewCell.self, forCellReuseIdentifier: SearchScreenTableViewCell.reuseIdentifier)
        
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        view.addSubview(tableView)
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
        
}

extension SearchScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleNewSearchText), object: nil)
        self.perform(#selector(handleNewSearchText), with: nil, afterDelay: 0.3)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }

    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }

}

extension SearchScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.output?.models.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchScreenTableViewCell.reuseIdentifier,
                for: indexPath) as? SearchScreenTableViewCell
        else {
            return UITableViewCell()
        }
        guard let model = output?.models[indexPath.section] else { return UITableViewCell() }
        cell.model = SearchScreenCellModel(from: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didTapOnSection(section: indexPath.section)
    }
    
}

extension SearchScreenViewController: SearchScreenViewInput {
    func stopActivityAnimating() {
        refreshControl.endRefreshing()
    }
    
    func updateTableView() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}
