//
//  CharacterModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 30.09.2024.
//

import Foundation

struct CharacterModel: Identifiable, Decodable, Equatable {
    
    var id: Int
    var name: String
    var role: String
    var movies: [String]
    var images: [String]
    var movieScenes: [MoviesScene]
    var link: String
}

struct MoviesScene: Hashable ,Decodable, Equatable {
    
    var id: Int
    var movie: String
    var sceneDescription: String
}
