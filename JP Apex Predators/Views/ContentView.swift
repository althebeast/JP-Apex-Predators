//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(PaywallViewModel.self) private var paywallViewModel
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    dinosList(geo: geo)
                }
                .navigationTitle("Jurassic Journey")
                .searchable(text: $vm.searchText)
                .autocorrectionDisabled()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) { sortButton }
                    ToolbarItem(placement: .topBarTrailing) { filterMenu }
                }
            }
        }
        .navigationSplitViewStyle(.automatic)
        .preferredColorScheme(.dark)
    }
    
    private var sortButton: some View {
        Button {
            withAnimation {
                viewModel.alphabetical.toggle()
            }
        } label: {
            Image(systemName: viewModel.alphabetical ? "film" : "textformat")
                .symbolEffect(.bounce, value: viewModel.alphabetical)
        }
    }
    
    private var filterMenu: some View {
        @Bindable var vm = viewModel
        
        return Menu {
            Picker("Filter", selection: $vm.currentTypeSelection.animation()) {
                ForEach(PredatorType.allCases) { type in
                    Label(type.rawValue.capitalized, systemImage: type.icon)
                }
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
    
    @ViewBuilder
    private func dinosList(geo: GeometryProxy) -> some View {
        ForEach(Array(viewModel.filteredDinos.enumerated()), id: \.offset) { index, predator in
            if index > 0 && !paywallViewModel.isSubsriptionActive {
                paywallLink(for: predator, geo: geo)
            } else {
                predatorLink(for: predator, geo: geo)
            }
        }
    }
    
    private func paywallLink(for predator: ApexPredator, geo: GeometryProxy) -> some View {
        NavigationLink(destination: Paywall()) {
            PredatorCard(predator: predator)
        }
        .frame(width: geo.size.width)
    }
    
    private func predatorLink(for predator: ApexPredator, geo: GeometryProxy) -> some View {
        NavigationLink(
            destination: PredatorDetail(
                predator: predator,
                position: .camera(MapCamera(centerCoordinate: predator.location, distance: 2000))
            )
        ) {
            withAnimation {
                PredatorCard(predator: predator)
            }
        }
        .frame(width: geo.size.width)
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
        .environment(PaywallViewModel())
}
