//
//  MoviePresenter.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/26.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit


class MoviePresenter {
    
    weak var view: MovieViewControllerInterface!
    var interactor: MovieInteractorInput!
    var router: MovieRouter!
    
}

extension MoviePresenter: MoviePresenterInterface {
    
    func requestMovies() {
        self.interactor.fetchMovies()
    }
}

extension MoviePresenter: MovieInteractorOutput {
    
    func moviesFetched(movies: [Movie]) {
        
        self.view.didFinishRequeset(datas: movies)
    }
    
}
