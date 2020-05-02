//
//  MovieDetailsAnoTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MovieDetailsReleaseDateTableViewCell: UITableViewCell {
    
    static func fileName() -> String {
        String(describing: self)
    }
    
    static func nib() -> UINib {
        UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        "movieReleaseDateCell"
    }

    @IBOutlet weak var lblYear: UILabel!
    
    func setup(with item: Movie) {
        let date = item.releaseDate
        self.lblYear.text = String(date.prefix(4))
    }
}
