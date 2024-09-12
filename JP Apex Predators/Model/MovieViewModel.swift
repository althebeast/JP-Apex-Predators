//
//  MovieViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel: ObservableObject {
    
    var parts = [Part]()
    
    var animate = false
    let firstColor = Color("FirstButtonColor")
    let secondColor = Color("SecondButtonColor")
    
    func fetcData() {
        MovieAPIManager().getData() { new in
            DispatchQueue.main.async {
                withAnimation {
                    self.parts = new
                }
            }
        }
    }
}
