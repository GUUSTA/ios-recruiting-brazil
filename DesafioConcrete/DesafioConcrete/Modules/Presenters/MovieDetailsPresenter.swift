//  Created Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

// MARK: View -
protocol MovieDetailsViewProtocol: AnyObject {
    
    var presenter: MovieDetailsPresenterProtocol? { get set }
    func requestViewSetup()
    func createActivityIndicator()
    func changeIsAnimating(to animation: Bool)
    /* Presenter -> ViewController */
}

// MARK: Presenter -
protocol MovieDetailsPresenterProtocol: AnyObject {
    
    var interactor: MovieDetailsInteractorInputProtocol? { get set }
    var tableViewDatasource: MovieDetailsTableViewDataSource? { get set }
    var movie: Movie? { get set }
    var genres: [Genre]? { get set }
    
    func callCreateActivityIndicator()
    func setAnimation(_ activate: Bool)
    func setupView(with tableView: UITableView,
                   and imageView: UIImageView)
    func getGenres()
}

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    private weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInteractorInputProtocol?
    private let router: MovieDetailsRouterProtocol
    
    var tableViewDatasource: MovieDetailsTableViewDataSource?
    var movie: Movie?
    var genres: [Genre]?
    
    init(interface: MovieDetailsViewProtocol,
         interactor: MovieDetailsInteractorInputProtocol?,
         router: MovieDetailsRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func setupView(with tableView: UITableView,
                   and imageView: UIImageView) {
        guard let movie = movie else { return }
        imageView.downloaded(from: movie.posterPath, contentMode: .scaleToFill)
        setupTable(with: tableView, using: movie)
    }
    
    private func setupTable(with tableView: UITableView,
                            using movie: Movie) {
        guard let genres = genres else { return }
        tableViewDatasource = MovieDetailsTableViewDataSource(using: movie,
                                                              with: tableView,
                                                              checking: genres)
    }
    
    func getGenres() {
        guard let interactor = interactor else { return }
        interactor.requestGenres()
    }
    
    func callCreateActivityIndicator() {
        guard let view = view else { return }
        view.createActivityIndicator()
    }
    
    func setAnimation(_ activate: Bool) {
        guard let view = view else { return }
        view.changeIsAnimating(to: activate)
    }
}

// MARK: MovieDetailsInteractorOutputProtocol -
extension MovieDetailsPresenter: MovieDetailsInteractorOutputProtocol {
    func sendGenres(genres: [Genre]) {
        self.genres = genres
        guard let view = view else { return }
        view.requestViewSetup()
    }
}
