//
//  MovieCell.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/10.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    fileprivate let thumbnaliImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return titleLabel
    }()
    
    fileprivate var gradientView: UIView =  {
        
        let gradientView = UIView()
        return gradientView
    }()
    
    fileprivate var scoreLabel: ScoreView = {
        
        let view = ScoreView()
        view.backgroundColor = .clear
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    fileprivate func setupViews() {
        
        self.contentView.addSubview(self.thumbnaliImage)
        self.contentView.addSubview(self.gradientView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.scoreLabel)
        
        gradientView.frame = CGRect(x: 0, y: self.frame.size.height - 120, width: self.frame.size.width, height: 120)
        UIColor.gradientStartColor(startColor: UIColor.RGBA(0, 0, 0, 0.0),
                                   endColor: UIColor.RGBA(0, 0, 0, 1.0),
                                   view: self.gradientView,
                                   type: .angle0)
        
        // 制約を設定
        self.setupConstrains()
    }
    
    fileprivate func setupConstrains() {
        
        self.thumbnaliImage.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.thumbnaliImage, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .top,     multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.thumbnaliImage, attribute: .leading,  relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.thumbnaliImage, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing,multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.thumbnaliImage, attribute: .bottom,   relatedBy: .equal, toItem: self, attribute: .bottom,  multiplier: 1.0, constant: 0)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.titleLabel, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .bottom,     multiplier: 1.0, constant: -50),
            NSLayoutConstraint(item: self.titleLabel, attribute: .leading,  relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: self.titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing,multiplier: 1.0, constant: -80),
            NSLayoutConstraint(item: self.titleLabel, attribute: .height,   relatedBy: .equal, toItem: nil, attribute: .height,  multiplier: 1.0, constant: 50)
        ])
        
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.scoreLabel, attribute: .top,      relatedBy: .equal, toItem: self, attribute: .bottom,     multiplier: 1.0, constant: -70 - 10),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing,multiplier: 1.0, constant: -10),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .height,   relatedBy: .equal, toItem: nil, attribute: .height,  multiplier: 1.0, constant: 70),
            NSLayoutConstraint(item: self.scoreLabel, attribute: .width,   relatedBy: .equal, toItem: nil, attribute: .width,  multiplier: 1.0, constant: 70)
        ])
    }
    
    // MARK: Public
    func setRowData(datas: [Movie], indexPath: IndexPath) {

        if datas.isEmpty { return }
        
        let model = datas[indexPath.row]
        let presenter = MovieCellPresenter(model: model)
        
        self.titleLabel.text = presenter.title
        self.scoreLabel.scoreLabel.text = presenter.rate
        
        self.scoreLabel.startAnimation(score: model.vote_average)
        
        self.thumbnaliImage.image = nil
        self.thumbnaliImage.kf.setImage(with: URL(string: presenter.url),
                                        placeholder: nil,
                                        options: nil) {[weak self] (image, error, cacheType, url) in
                                            guard let `self` = self else { return }
                                            if cacheType != .memory {
                                                UIView.transition(with:self.thumbnaliImage,
                                                                          duration: 0.28,
                                                                          options: .transitionCrossDissolve,
                                                                          animations: nil, completion: nil)
                                            }

        }
    }
    
}
