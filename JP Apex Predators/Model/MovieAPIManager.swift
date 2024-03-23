//
//  MovieAPIManager.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation

struct MovieAPIManager {
    
    let apiKey = "4b0e5a6d89f8dcc084a926adc60a7725"
    
    func getData (_ completion:@escaping ([Part]) -> ()) {
        
        let urlString = "https://api.themoviedb.org/3/collection/328-jurassic-park-collection?api_key=4b0e5a6d89f8dcc084a926adc60a7725"
        
        guard let url = URL(string: urlString) else {
            print("MovieAPI: Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("MovieAPI: Could not retrieve data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let movieData = try decoder.decode(MovieModel.self, from: data)
                completion(movieData.parts)
            } catch {
                print("MovieAPI: \(error)")
            }
        }
        .resume()
    }
}
