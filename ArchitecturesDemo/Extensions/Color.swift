//
//  Color.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/16.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

//public enum GradientType: Integer {
//    case angle0
//    case angle45
//    case angle90
//}

enum gradient {
    case angle0
    case angle45
    case angle90
}

extension UIColor {
    
    class func RGBA(_ r : Int, _ g : Int, _ b : Int, _ alpha : CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
    
    class func RGB(_ r : Int, _ g : Int, _ b : Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1.0))
    }

    class func gradientStartColor(startColor: UIColor, endColor: UIColor, view: UIView, type: gradient) {
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        
        switch type {
        case .angle0:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        case .angle45:
            startPoint = CGPoint(x: 1.0, y: 0.0)
            endPoint = CGPoint(x: 0.0, y: 1.0)
        case .angle90:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
