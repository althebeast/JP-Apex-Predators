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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
