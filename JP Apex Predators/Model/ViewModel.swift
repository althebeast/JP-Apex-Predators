//
//  ViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 12.03.2024.
//

import Foundation
import SwiftUI

@Observable
class ViewModel: ObservableObject {
    
    let predators = PredatorController()
    
    var searchText = ""
    var alphabetical = false
    var currentTypeSelection = PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentTypeSelection)
        
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
}
