//
//  MovieRouter.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/26.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class MovieRouter {
  
    weak var viewController: UIViewController?
}

extension MovieRouter: MovieRouterWireframe {
    
    static func assembleModule() -> UIViewController {
        
        let controller = MovieViewController()
        let presenter = MoviePresenter()
        let interactor = MovieInteractor()
        let router = MovieRouter()
        
        controller.presenter = presenter
        
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        
        router.viewController = controller
        
        return controller
    }
}
