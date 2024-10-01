//
//  JP_Apex_PredatorsApp.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 21.01.2024.
//

import SwiftUI
import RevenueCat

@main
struct JP_Apex_PredatorsApp: App {
    
    @AppStorage("isLightMode") private var isLightMode = false
    @State var viewModel = ViewModel()
    @State var bookmarkvm = BookmarkViewModel()
    @State var movievm = MovieViewModel()
    @State var paywallVm = PaywallViewModel()
    @State var characterVm = CharacterViewModel()
    
    var body: some Scene {
        WindowGroup {
            PredatorTabView()
                .environment(ViewModel())
                .environment(BookmarkViewModel())
                .environment(MovieViewModel())
                .environment(PaywallViewModel())
                .environment(CharacterViewModel())
                .preferredColorScheme(isLightMode ? .light : .dark)
        }
    }
    
    init() {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_COoVDmAQazLwdADseTbEwSXPzkr")
        
    }
}
