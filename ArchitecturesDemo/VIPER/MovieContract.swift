//
//  MovieContract.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/27.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

/* Controller */

// Presenterfが所有
protocol MovieViewControllerInterface: class {
    
    func didFinishRequeset(datas: [Movie])
    
}

/* Presenter */

// Controllerが所有
protocol MoviePresenterInterface: class {
    func requestMovies()
}

// Interactorが所有
protocol MovieInteractorOutput: class {
    func moviesFetched(movies: [Movie])
}


/* interractor */

// Presenterfが所有
protocol MovieInteractorInput: class {
    func fetchMovies()
}

/* Router */

// Presenterfが所有
protocol MovieRouterWireframe: class {
    weak var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
}
