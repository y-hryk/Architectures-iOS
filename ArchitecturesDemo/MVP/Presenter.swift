//
//  Presenter.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/23.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol PresenterDelegate: class {
    
    func presenterDidChangeControllerStatus(presenter: Presenter, state: Presenter.controllerState)
    func presenterDidFinishRequeset(presenter: Presenter)
}

class Presenter {
    
    enum controllerState : String {
        case content = "Content"
        case loading = "Loading"
        case error = "Error"
    }

    weak var delegate: PresenterDelegate?
    var movies = [Movie]()
    
    fileprivate var currentPage = 1
    fileprivate var state: controllerState = .content {
        willSet {
            self.state = newValue
            self.delegate?.presenterDidChangeControllerStatus(presenter: self, state: self.state)
        }
    }
    
    // MARK: Public
    func requestMovies(isNext: Bool = false) {
        
        if self.state == .loading { return }
        
        if !isNext {
            self.movies = [Movie]()
            self.currentPage = 1
        }
        
        let domain = APIConfig.baseDomain + "/discover/movie"
        let query = "?api_key=" + APIConfig.accessToken + "&page=" + "\(self.currentPage)" + "&sort_by=popularity.desc"
        let url = URL(string: domain + query)!
        
        
        self.state = .loading
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
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
                        self.delegate?.presenterDidFinishRequeset(presenter: self)
                    }
                }
                
            } else {
                self.state = .error
            }
            
            }.resume()
    }

}
