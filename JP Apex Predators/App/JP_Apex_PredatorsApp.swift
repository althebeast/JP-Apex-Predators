//
//  JP_Apex_PredatorsApp.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI

@main
struct JP_Apex_PredatorsApp: App {
    
    @State var viewModel = ViewModel()
    @State var bookmarkvm = BookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            PredatorTabView()
                .environment(viewModel)
                .environment(bookmarkvm)
        }
    }
}
