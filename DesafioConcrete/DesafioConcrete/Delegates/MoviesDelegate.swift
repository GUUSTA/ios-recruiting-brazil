//
//  MoviesDelegate.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation

protocol MoviesDelegate: AnyObject {
    func didSelectMovie(at item: IndexPath)
    func fetchMoreMovies()
}
