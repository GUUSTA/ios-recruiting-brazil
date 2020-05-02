//
//  FavoritesViewControllerSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 08/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class FavoritesViewControllerSpec: XCTestCase {
    
    func testSetup() {
        let viewController = FavoritesRouter.createModule()
        _ = viewController.view
    }
}
