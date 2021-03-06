//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

// MARK: View -
protocol FavoritesViewProtocol: AnyObject {
    
    var presenter: FavoritesPresenterProtocol? { get set }
    func setupSearchController()
    func reloadTableView()
    func showResultImage(isHidden: Bool, text: String)
    func createFilterButton()
    /* Presenter -> ViewController */
}

// MARK: Presenter -
protocol FavoritesPresenterProtocol: AnyObject {
    
    var interactor: FavoritesInteractorInputProtocol? { get set }
    var movies: [Movie]? { get set }
    var filteredMovies: [Movie]? { get set }
    var tableViewDataSource: FavoritesTableViewDataSource? { get set }
    var tableViewDelegate: FavoritesTableViewDelegate? { get set }
    func getFavorites()
    func setupTableView(with tableView: UITableView, isSearchBarEmpty: Bool)
    func callSetupSearchController()
    func filterMovies(using text: String)
    func callCreateFilterButton()
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    private weak var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorInputProtocol?
    private let router: FavoritesRouterProtocol
    var tableViewDataSource: FavoritesTableViewDataSource?
    var tableViewDelegate: FavoritesTableViewDelegate?
    var filteredMovies: [Movie]? = []
    var movies: [Movie]?
    
    init(interface: FavoritesViewProtocol,
         interactor: FavoritesInteractorInputProtocol?,
         router: FavoritesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getFavorites() {
        guard let interactor = interactor else { return }
        interactor.requestMovies()
    }
    
    func setupTableView(with tableView: UITableView, isSearchBarEmpty: Bool) {
        guard let movies = movies, let filteredMovies = filteredMovies else { return }
        let moviesToDataSource = isSearchBarEmpty ? movies : filteredMovies
        tableViewDelegate = FavoritesTableViewDelegate(self)
        tableViewDataSource = FavoritesTableViewDataSource(using: moviesToDataSource,
                                                           with: tableView,
                                                           delegate: tableViewDelegate!)
    }
    
    func callSetupSearchController() {
        guard let view = view else { return }
        view.setupSearchController()
    }
    
    func filterMovies(using text: String) {
        guard let movies = movies else { return }
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            movie.title.lowercased().contains(text.lowercased())
        }
        
        guard let filteredMovies = filteredMovies, let view = view else { return }
        if filteredMovies.isEmpty && text.isEmpty {
            view.showResultImage(isHidden: false, text: text)
        } else {
            view.showResultImage(isHidden: true, text: text)
        }
        view.reloadTableView()
    }
    
    func callCreateFilterButton() {
        guard let view = view else { return }
        view.createFilterButton()
    }
}

// MARK: FavoritesInteractorOutputProtocol
extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func sendMovies(movies: [Movie]) {
        self.movies = movies
    }
}

// MARK: FavoritesDelegate
extension FavoritesPresenter: FavoritesDelegate {
    func unfavoriteMovie(atId: Int) {
        guard let movies = movies, let interactor = interactor, let view = view else { return }
        interactor.unfavorite(movie: movies[atId])
        interactor.requestMovies()
        view.reloadTableView()
    }
}
