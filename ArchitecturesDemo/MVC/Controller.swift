//
//  Controller.swift
//  ArchitecturesDemo
//
//  Created by h.yamaguchi on 2017/01/10.
//  Copyright © 2017年 h.yamaguchi. All rights reserved.
//

import UIKit

class Controller: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=0a06fbb707cb2165dffcd8d27fd04365")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let responseData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any] {
                
                if let results = responseData["results"] as? [[String: Any]] {
                    let movies = results.map({ (value) -> Movie in
                                    return Movie(id             : String(value["id"] as? Int ?? 0),
                                                 title          : value["title"] as? String ?? "",
                                                 backdrop_path  : value["backdrop_path"] as? String ?? "",
                                                 vote_average   : value["vote_average"] as? Float ?? 0.0)
                                })
                    print("movies: \(movies)")
                }
                
            } else {
                
            }
            
        }.resume()
    }

}
