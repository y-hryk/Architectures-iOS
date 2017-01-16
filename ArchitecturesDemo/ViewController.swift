//
//  ViewController.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2016/12/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }


    func setupViews() {
        
    }
    
    private func fetchData(completion: (() -> Void)?) {
        self.setupViews()
        completion?()
    }
}

