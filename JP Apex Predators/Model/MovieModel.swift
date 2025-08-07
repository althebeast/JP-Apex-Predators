//
//  MovieModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation

struct Part: Identifiable, Codable {
    let id = UUID()
    let title: String
    let released: Date
    let imdbRating: Double
    let plot: String
    let poster: String
    let genre: String
    let director: String
    let awards: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case imdbRating
        case plot = "Plot"
        case poster = "Poster"
        case genre = "Genre"
        case director = "Director"
        case awards = "Awards"
    }
    
    var imageURL: URL? {
        URL(string: poster)
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            title = try container.decode(String.self, forKey: .title)
            
            // Released date parsing
            let releasedString = try container.decode(String.self, forKey: .released)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            released = formatter.date(from: releasedString) ?? Date.distantPast
            
            // imdbRating parsing
            let ratingString = try container.decode(String.self, forKey: .imdbRating)
            imdbRating = Double(ratingString) ?? 0.0
            
            plot = try container.decode(String.self, forKey: .plot)
            poster = try container.decode(String.self, forKey: .poster)
            genre = try container.decode(String.self, forKey: .genre)
            director = try container.decode(String.self, forKey: .director)
            awards = try container.decode(String.self, forKey: .awards)
        }
    }
