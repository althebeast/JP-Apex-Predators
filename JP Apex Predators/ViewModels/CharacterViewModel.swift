//
//  CharacterViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 30.09.2024.
//

import Foundation

@Observable
class CharacterViewModel {
    
    let characters = CharacterController()
    
    var selectedCharacter: CharacterModel?
    
    var searchText = ""
    var alphabetical = false
    
    var filteredCharacters: [CharacterModel] {
        
        characters.sort(by: alphabetical)
        
        return characters.search(for: searchText)
    }
}
