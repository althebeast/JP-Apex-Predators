//
//  TabView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct PredatorTabView: View {
    
    @AppStorage("isLightMode") public var isLightMode = false
    
    var body: some View {
        TabView() {
            ContentView()
                .tabItem {
                    VStack{
                        Image("dinosaur2")
                        Text("Dinosaurs")
                    }
                }
            
            CharacterCard()
                .tabItem {
                    VStack {
                        Image(systemName: "person.2.crop.square.stack.fill")
                        Text("Characters")
                    }
                }
            
            MoviesCard()
                .tabItem {
                    VStack {
                        Image("movies-2")
                        Text("Movies")
                    }
                }
            
            BookmarkCard()
                .tabItem {
                    VStack {
                        Image("dinosaur3")
                        Text("Favorites")
                    }
                }
            
            OptionScreen()
                .tabItem { 
                    VStack {
                        Image("egg-2")
                        Text("Settings")
                    }
                }
        }
        .tint(isLightMode ? .black : .accentColor)
    }
}

#Preview {
    PredatorTabView()
}
