//
//  Debuggable.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/16.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol Debuggable: CustomStringConvertible {
    
}

extension Debuggable {
    
    var description: String {
        
        let mirror = Mirror(reflecting: self)
        var str = ""
        mirror.children.forEach { str = str + "\n  \($0.label!) = \($0.value)" }
        
        return "\n{" + str + "\n}"
    }
}
