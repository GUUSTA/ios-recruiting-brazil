//
//  MovieDetailFirstSectionTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MovieDetailsTitleTableViewCell: UITableViewCell {
    static func fileName() -> String {
        String(describing: self)
    }
    
    static func nib() -> UINib {
        UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        "movieTitleCell"
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    weak var delegate: FavoriteMovieDelegate?
    var item: Movie?
    
    func setup(with item: Movie) {
        self.lblTitle.text = item.title
        self.item = item
        if DataManager.shared.checkData(movieId: item.id) {
            self.btnFavorite.setImage(CustomImages.favorited.getImage(), for: .normal)
        } else {
            self.btnFavorite.setImage(CustomImages.unfavorited.getImage(), for: .normal)
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let delegate = delegate, let item = item else { return }
        delegate.favoriteMovie(movie: item)
    }
}
