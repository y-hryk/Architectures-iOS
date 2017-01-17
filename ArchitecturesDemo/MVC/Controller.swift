//
//  Controller.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/10.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class Controller: UIViewController {
    
    fileprivate enum controllerState : String {
        case content = "Content"
        case loading = "Loading"
        case error = "Error"
    }
    
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
    
    fileprivate lazy var refreshControl: UIRefreshControl =  {
       
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    fileprivate var movies = [Movie]()
    fileprivate var currentPage = 1
    fileprivate var state: controllerState = .content
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubViews")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.baseColor()
        self.view.addSubview(self.collectionView)
        
        self.refreshControl.addTarget(self, action: #selector(request(control:)), for: .valueChanged)
        self.collectionView.addSubview(self.refreshControl)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // 制約を設定
        self.setupConstraints()
        
        //
        self.request(control: nil)
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
    
    @objc fileprivate func request(control: UIRefreshControl?) {
        
        if self.state == .loading { return }
        
        if let control = control {
            self.movies = [Movie]()
            self.currentPage = 1
            control.beginRefreshing()
        }
        
        self.state = .loading
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=0a06fbb707cb2165dffcd8d27fd04365&page=" + "\(self.currentPage)" + "&sort_by=popularity.desc")!
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            control?.endRefreshing()
            guard let `self` = self else { return }
            guard let data = data else {
                self.state = .error
                return
            }
            
            if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any] {
                
                if let results = responseData["results"] as? [[String: Any]] {
                    
                    let movies = results.map({ (value) -> Movie in
                        let movie = Movie()
                        movie.id            = String(value["id"] as? Int ?? 0)
                        movie.title         = value["title"] as? String ?? ""
                        movie.backdrop_path = value["backdrop_path"] as? String ?? ""
                        movie.vote_average  = value["vote_average"] as? Float ?? 0.0
                        
                        return movie
                    })
                    
                    self.movies = self.movies + movies
                    self.currentPage += 1
                    self.state = .content
                   
                    DispatchQueue.main.async {
                        NSLog("movies: \(self.movies)")
                        self.collectionView.reloadData()
                    }
                }
                
            } else {
                self.state = .error
            }
            
        }.resume()
    }
}


// MARK: UICollectionViewDataSource
extension Controller: UICollectionViewDataSource {
    
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
extension Controller: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
}

// MARK: UIScrollViewDelegate
extension Controller: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height) {
        
            self.request(control: nil)
        }
    }
}


