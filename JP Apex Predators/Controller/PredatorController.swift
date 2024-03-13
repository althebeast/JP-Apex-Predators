//
//  PredatorController.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import Foundation

class PredatorController: ObservableObject {
    
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            
            do{
                let data = try Data(contentsOf: url) // yukarda oluşturduğum json'ı bu data isimi altında saklıyorum.
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // eğer json dosyasında snakecase yani isimler _ ile yazılmışsa onu snakeCase'e çeviriyor.
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
            
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            
            alphabetical ? predator1.name < predator2.name : predator1.id < predator2.id
            
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
