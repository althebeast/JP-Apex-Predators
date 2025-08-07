//
//  MovieAPIManager.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovie(byTitle title: String) async throws -> Part
}

struct MovieService: MovieServiceProtocol {
    func fetchMovie(byTitle title: String) async throws -> Part {
        let apiKey = "111f1716"
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
        let urlString = "https://www.omdbapi.com/?t=\(encodedTitle)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let movie = try JSONDecoder().decode(Part.self, from: data)
        return movie
    }
}


