//
//  FavoritesImages.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 07/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

enum CustomImages: String {
    case filter = "FilterIcon"
    case favorited = "favorite_full_icon"
    case unfavorited = "favorite_gray_icon"
    
    func getImage() -> UIImage {
        UIImage(named: "\(self.rawValue)") ?? UIImage()
    }
}
