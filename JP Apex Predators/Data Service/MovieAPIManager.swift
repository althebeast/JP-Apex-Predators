//
//  MovieAPIManager.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation

struct MovieAPIManager {
    
    let endPoint = "https://api.themoviedb.org/3/collection"
    let collectionId = "/328-jurassic-park-collection"
    let apiKey = Bundle.main.infoDictionary? ["API_KEY"] as? String
    
    func getData (_ completion:@escaping ([Part]) -> ()) {
        
        let urlString = "\(endPoint)\(collectionId)?api_key=\(apiKey!)"
        
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
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let movieData = try decoder.decode(MovieModel.self, from: data)
                completion(movieData.parts)
            } catch {
                print("MovieAPI: \(error)")
            }
        }
        .resume()
    }
}
