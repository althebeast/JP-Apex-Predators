//
//  MovieModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation

struct MovieModel: Decodable, Identifiable {
    
    var id: Int
    var name: String
    var overview: String
    var posterPath: String
    var parts: [Part]
    
    enum CodingKeys: String, CodingKey {
        
        case posterPath = "poster_path"
        
        case id
        case name
        case overview
        case parts
        
    }
    
}

struct Part: Decodable, Identifiable {
    
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var releaseDate: Date
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        
        case id
        case title
        case overview
    }
    
    var imageURL: URL? {
        guard let posterPath else {
            return nil
        }
        
        let fullImage = "https://image.tmdb.org/t/p/w500\(posterPath)"
        
        return URL(string: fullImage)
    }
}
