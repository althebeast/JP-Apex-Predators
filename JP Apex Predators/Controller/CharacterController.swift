//
//  CharacterController.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 30.09.2024.
//

import Foundation

class CharacterController: ObservableObject {
    
    //Array of all characters
    var movieCharacters: [CharacterModel] = []
    var allMovieCharacters: [CharacterModel] = []
    
    init() {
        decodeCharacterData()
    }
    
    func decodeCharacterData() {
        
        if let url = Bundle.main.url(forResource: "jpapCharacters", withExtension: "json") {
            
            do{
                let data = try Data(contentsOf: url) // yukarda oluşturduğum json'ı bu data isimi altında saklıyorum.
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // eğer json dosyasında snakecase yani isimler _ ile yazılmışsa onu snakeCase'e çeviriyor.
                allMovieCharacters = try decoder.decode([CharacterModel].self, from: data)
                movieCharacters = allMovieCharacters
            } catch {
                print("Error decoding JSON data: \(error)")
            }
            
        }
    }
    
    func search(for searchTerm: String) -> [CharacterModel] {
        if searchTerm.isEmpty {
            return movieCharacters
        } else {
            return movieCharacters.filter { character in
                character.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        movieCharacters.sort { character1, character2 in
            
            alphabetical ? character1.name < character2.name : character1.id < character2.id
            
        }
    }
}
