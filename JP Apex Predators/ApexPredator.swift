//
//  ApexPredator.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import Foundation

struct ApexPredator: Codable {
    
    let id: Int
    let name: String
    let type: String
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
}

struct MovieScene: Codable {
    
    let id: Int
    let movie: String
    let sceneDescription: String
    
}
