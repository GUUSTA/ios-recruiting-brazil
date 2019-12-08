//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

final class FavoritesViewController: UIViewController {
    //MARK: - Variables
    var presenter: FavoritesPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRemoveFilter: UIButton!
    @IBOutlet weak var btnRemoveFilterHeight: NSLayoutConstraint!
    @IBOutlet weak var imgSearchEmptyState: UIImageView!
    @IBOutlet weak var lblSearchEmptyState: UILabel!
    var activityIndicatorView = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

//MARK: - Life cycles
extension FavoritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.callSetupSearchController()
        presenter.callCreateFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Favorites"
        guard let presenter = presenter else { return }
        presenter.getFavorites()
        presenter.setupTableView(with: tableView, isSearchBarEmpty: isSearchBarEmpty)
    }
}

//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    func showResultImage(isHidden: Bool, text: String) {
        imgSearchEmptyState.isHidden = isHidden
        lblSearchEmptyState.isHidden = isHidden
        lblSearchEmptyState.text = "No resuls for '\(text)'"
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func reloadTableView() {
        guard let presenter = presenter else { return }
        presenter.setupTableView(with: tableView, isSearchBarEmpty: isSearchBarEmpty)
    }
    
    func createFilterButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: CustomImages.filter.getImage(), style: .plain, target: self, action: #selector(filterTapped))
    }
}

//MARK: -
extension FavoritesViewController {
    @objc
    func filterTapped() {
        // TODO
    }
}

//MARK: - UISearchResultsUpdating
extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let presenter = presenter, let text = searchController.searchBar.text else { return }
        presenter.filterMovies(using: text)
    }
}

