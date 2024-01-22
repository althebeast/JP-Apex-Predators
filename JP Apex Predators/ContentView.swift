//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    let apController = PredatorController()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(apController.apexPredators) { predator in
                    NavigationLink(destination: Text("Dino details will appeir here")) {
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Predators")
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
