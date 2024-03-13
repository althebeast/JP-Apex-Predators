//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        
        
        
        @Bindable var vm = viewModel
        
        NavigationStack {
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.filteredDinos) { predator in
                            VStack {
                                NavigationLink(destination: PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 2000)))) {
                                    withAnimation {
                                        PredatorCard(predator: predator)
                                    }
                                }
                            }
                            .frame(width: geo.size.width)
                        }
                    .navigationTitle("Jurassic Journey")
                    .searchable(text: $vm.searchText)
                    .autocorrectionDisabled()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation {
                                    viewModel.alphabetical.toggle()
                                }
                            },
                                   label: {
                                Image(systemName: viewModel.alphabetical ? "film" : "textformat")
                                    .symbolEffect(.bounce, value: viewModel.alphabetical)
                                // ? anlamı = alphabetical doğru ise... film kullan : anlamı doğru değil ise... textformat kullan. Ve bu şekilde yazılınca adı Ternary if statement oluyor.
                            })
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Picker("Filter", selection: $vm.currentTypeSelection.animation()) {
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
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
