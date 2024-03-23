//
//  TabView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct PredatorTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            MoviesCard()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
            
            BookmarkCard()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

#Preview {
    PredatorTabView()
}
