//
//  FavoriteMovieTableViewCellSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class FavoriteMovieTableViewCellSpec: XCTestCase {
    
    func testIdentifier() {
        XCTAssertTrue(FavoriteMovieTableViewCell.identifier() == "favoriteMovieTableView")
    }
}
