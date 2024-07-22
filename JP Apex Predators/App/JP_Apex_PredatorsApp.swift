//
//  JP_Apex_PredatorsApp.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI

@main
struct JP_Apex_PredatorsApp: App {
    
    @StateObject var viewModel = ViewModel()
    @StateObject var bookmarkvm = BookmarkViewModel()
    @StateObject var movievm = MovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            PredatorTabView()
                .environmentObject(ViewModel())
                .environmentObject(BookmarkViewModel())
                .environmentObject(MovieViewModel())
        }
    }
}
