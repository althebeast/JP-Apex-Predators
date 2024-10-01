//
//  CharacterCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 29.09.2024.
//

import SwiftUI

struct CharacterCard: View {
    @Environment(CharacterViewModel.self) private var characterViewModel
    @Environment(PaywallViewModel.self) private var paywallViewModel
    
    var body: some View {
        @Bindable var characterVM = characterViewModel
        @Bindable var paywallVM = paywallViewModel
        
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    charactersGrid(geo: geo)
                }
                .scrollIndicators(.hidden)
                .searchable(text: $characterVM.searchText)
                .autocorrectionDisabled()
            }
            .navigationTitle("Characters")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { sortButton }
            }
        }
        .sheet(item: $characterVM.selectedCharacter) { character in
            CharacterDetailView(character: character)
        }
        .sheet(isPresented: $paywallVM.isPaywallPresented) {
            Paywall()
        }
    }
    
    private func charactersGrid(geo: GeometryProxy) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: geo.size.width > 700 ? 350 : 150))], spacing: 20) {
            ForEach(Array(characterViewModel.filteredCharacters.enumerated()), id: \.offset) { index, character in
                characterButton(for: character, at: index)
            }
        }
        .padding()
    }
    
    private func characterButton(for character: CharacterModel, at index: Int) -> some View {
        Button {
            if index > 0 && !paywallViewModel.isSubsriptionActive {
                paywallViewModel.isPaywallPresented = true
            } else {
                characterViewModel.selectedCharacter = character
            }
        } label: {
            CharacterView(character: character)
        }
    }
    
    private var sortButton: some View {
        Button {
            withAnimation(.easeInOut) {
                characterViewModel.alphabetical.toggle()
            }
        } label: {
            Image(systemName: characterViewModel.alphabetical ? "film" : "textformat")
                .symbolEffect(.bounce, value: characterViewModel.alphabetical)
        }
    }
}

struct CharacterView: View {
    let character: CharacterModel
    
    var body: some View {
        VStack {
            Image(character.name)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .white.opacity(0.5), radius: 5, x: -3, y: -8)
                .overlay {
                    overlayGradient
                    characterNameOverlay
                }
        }
    }
    
    private var overlayGradient: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .clear, location: 0.8),
                Gradient.Stop(color: .black, location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var characterNameOverlay: some View {
        VStack {
            Spacer()
            Text(character.name)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(5)
                .shadow(color: .black, radius: 15)
        }
    }
}

#Preview {
    CharacterCard()
        .environment(CharacterViewModel())
        .environment(PaywallViewModel())
        .preferredColorScheme(.dark)
}
