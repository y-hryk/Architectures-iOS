//
//  MovieInteractor.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/04/26.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class MovieInteractor: NSObject {
    
    weak var output: MovieInteractorOutput!
}


extension MovieInteractor: MovieInteractorInput {
    
    func fetchMovies() {
    
        let domain = APIConfig.baseDomain + "/discover/movie"
        let query = "?api_key=" + APIConfig.accessToken + "&page=" + "\(1)" + "&sort_by=popularity.desc"
        let url = URL(string: domain + query)!
        
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            guard let `self` = self else { return }
            guard let data = data else {
//                self.state = .error
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
                    
                    DispatchQueue.main.async {
                        NSLog("movies: \(movies)")
                        `self`.output.moviesFetched(movies: movies)
                    }
                }
                
            } else {
//                self.state = .error
            }
            
            }.resume()
        
    }
}
