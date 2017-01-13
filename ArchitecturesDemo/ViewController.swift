//
//  ViewController.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2016/12/28.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setupViews() {
        
    }
    
    private func fetchData(completion: (() -> Void)?) {
        self.setupViews()
        completion?()
    }
}

