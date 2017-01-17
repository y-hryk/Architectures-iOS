//
//  ScoreView.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/16.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    let scoreLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "0"
        return label
    }()
    
    let graphMaxShapeLayer: CAShapeLayer = {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.RGB(135, 135, 135).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        return shapeLayer
    }()
    
    let graphCurrentShapeLayer: CAShapeLayer = {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        return shapeLayer
    }()
    
    var currentScore: Float = 0.0
    var isAnimated: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.scoreLabel)
        
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.scoreLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX ,multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY ,multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .top,   relatedBy: .equal, toItem: self, attribute: .top,  multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .bottom,   relatedBy: .equal, toItem: self, attribute: .bottom,  multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .leading,   relatedBy: .equal, toItem: self, attribute: .leading,  multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .trailing,   relatedBy: .equal, toItem: self, attribute: .trailing,  multiplier: 1.0, constant: 0)
        ])
    
        self.layer.addSublayer(self.graphMaxShapeLayer)
        self.layer.addSublayer(self.graphCurrentShapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        
        self.addSubview(self.scoreLabel)
    }
    
    
    // MARK: Public
    
    func startAnimation(score: Float) {
        
        self.currentScore = score
        let center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        let radius = self.frame.size.width / 2.0
        let startAngle = CGFloat(-M_PI_2)
        let current_endAngle = (CGFloat(self.currentScore / 10.0) * 2.0 * CGFloat(M_PI)) + CGFloat(-M_PI_2)
        let current_path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: current_endAngle, clockwise: true)
        self.graphCurrentShapeLayer.path = current_path.cgPath

        CATransaction.begin()
        CATransaction.setCompletionBlock({
        })
    
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.75
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.graphCurrentShapeLayer.add(animation, forKey: "circleAnim")
        
        CATransaction.commit()
    }
    
    // MARK: Over ride
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        let radius = self.frame.size.width / 2.0
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = (2.0 * CGFloat(M_PI)) + CGFloat(-M_PI_2)
        let path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.graphMaxShapeLayer.path = path.cgPath
        
        
        let current_endAngle = (CGFloat(self.currentScore / 10.0) * 2.0 * CGFloat(M_PI)) + CGFloat(-M_PI_2)
        let current_path = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: current_endAngle, clockwise: true)
        self.graphCurrentShapeLayer.path = current_path.cgPath
    }
}
