//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = PredatorController()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentTypeSelection = PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentTypeSelection)
        
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredDinos) { predator in
                    NavigationLink(destination: PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))) {
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    },
                           label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                        // ? anlamı = alphabetical doğru ise... film kullan : anlamı doğru değil ise... textformat kullan. Ve bu şekilde yazılınca adı Ternary if statement oluyor.
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentTypeSelection.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
