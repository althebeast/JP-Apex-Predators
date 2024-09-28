//
//  TabView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct PredatorTabView: View {
    
    @AppStorage("isLightMode") public var isLightMode = false
    //@State private var activeTab = 0
    
    var body: some View {
        TabView() {
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
            
            OptionScreen()
                .tabItem { 
                    Label("Settings", systemImage: "gear")
                }
        }
        .tint(isLightMode ? .black : .accentColor)
    }
}

#Preview {
    PredatorTabView()
}
