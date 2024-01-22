//
//  PredatorController.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import Foundation

class PredatorController {
    
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
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            } catch {
                print("Error decoding JSON data: \(error)")
            }
            
        }
    }
}
