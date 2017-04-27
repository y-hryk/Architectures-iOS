//
//  SwitchVC.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/26.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

struct SwitchVC {
    
    static func mainController() -> UIViewController {
        
        return MovieRouter.assembleModule()
    }

}
