//
//  FavoritesDelegate.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 06/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation

protocol FavoritesDelegate: AnyObject {
    func unfavoriteMovie(atId: Int)
}
