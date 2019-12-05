//  Created Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
import UIKit

final class MovieDetailsViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detalisTableView: UITableView!
    var activityIndicatorView = UIActivityIndicatorView()
    var presenter: MovieDetailsPresenterProtocol?
}

//MARK: - Life cycles
extension MovieDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        activityIndicatorView.frame = UIScreen.main.bounds
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        presenter.getGenres()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movie"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

//MARK: - MovieDetailsViewProtocol
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func requestViewSetup() {
        guard let presenter = presenter else { return }
        activityIndicatorView.stopAnimating()
        presenter.setupView(with: detalisTableView, and: posterImageView)
    }
}
