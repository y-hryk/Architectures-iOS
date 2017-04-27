//
//  MovieViewController.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/26.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    fileprivate var collectionView: UICollectionView = {
        
        let cellWidth = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 9) / 16)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        return collectionView
    }()
    
    fileprivate var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var presenter: MoviePresenterInterface!
    var movies = [Movie]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.baseColor()
        self.view.addSubview(self.collectionView)
        
        // Selector setting
        self.collectionView.addSubview(self.refreshControl)
        
        // Delegate & DataSource
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // 制約を設定
        self.setupConstraints()
        
        self.presenter.requestMovies()
    }
    
    // MARK: Private
    fileprivate func setupConstraints() {
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.collectionView, attribute: .top,      relatedBy: .equal, toItem: view, attribute: .top,     multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .leading,  relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing,multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .bottom,   relatedBy: .equal, toItem: view, attribute: .bottom,  multiplier: 1.0, constant: 0)
            ])
    }
}

// MARK: MovieViewInterface
extension MovieViewController: MovieViewControllerInterface {
    
    func didFinishRequeset(datas: [Movie]) {
        self.movies = datas
        
        
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
    }

}

// MARK: UICollectionViewDataSource
extension MovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        cell.setRowData(datas: self.movies, indexPath: indexPath)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension MovieViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
