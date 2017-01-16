//
//  Controller.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/10.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class Controller: UIViewController {

    fileprivate var collectionView: UICollectionView = {
        let cellWidth = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 9) / 16)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
       
        return collectionView
    }()
    
    fileprivate var movies = [Movie]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.collectionView, attribute: .top,      relatedBy: .equal, toItem: view, attribute: .top,     multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .leading,  relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing,multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .bottom,   relatedBy: .equal, toItem: view, attribute: .bottom,  multiplier: 1.0, constant: 0)
        ])
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=0a06fbb707cb2165dffcd8d27fd04365")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any] {
                
                if let results = responseData["results"] as? [[String: Any]] {

                    self.movies = results.map({ (value) -> Movie in
                                    let movie = Movie()
                                    movie.id            = String(value["id"] as? Int ?? 0)
                                    movie.title         = value["title"] as? String ?? ""
                                    movie.backdrop_path = value["backdrop_path"] as? String ?? ""
                                    movie.vote_average  = value["vote_average"] as? Float ?? 0.0
                        
                                    return movie
                                })
                    NSLog("movies: \(self.movies)")
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            } else {
                
            }
            
        }.resume()
    }
    
}

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


