//
//  MovieCellPresenter.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/24.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

struct MovieCellPresenter {
    
    var title: String = ""
    var rate: String  = ""
    var url: String = ""
    
    init(model: Movie) {
        
        self.title = model.title
        self.rate = "\(model.vote_average)"
        self.url = APIConfig.IMAGE_BASE_DOMINE_w780 + model.backdrop_path
    }
    
}
