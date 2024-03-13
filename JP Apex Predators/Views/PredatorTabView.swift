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
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkCard()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    PredatorTabView()
}
