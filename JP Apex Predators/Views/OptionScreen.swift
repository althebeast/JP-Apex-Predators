//
//  OptionScreen.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 1.09.2024.
//

import SwiftUI
import StoreKit

struct OptionScreen: View {
    
    @AppStorage("isLightMode") public var isLightMode = false
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    Toggle(isOn: $isLightMode, label: {
                        HStack {
                            Image(systemName: "sun.max.fill")
                            Text("Light Mode")
                                .font(.title3)
                        }
                    })
                } header: {
                    Text("Color Scheme")
                }

                
                Section(header: Text("About the app")) {
                            RateTheApp()
                                .foregroundStyle(isLightMode ? Color(.black) : Color(.white))
                            Recommend()
                                .foregroundStyle(isLightMode ? Color(.black) : Color(.white))
                            Feedback()
                                .foregroundStyle(isLightMode ? Color(.black) : Color(.white))
                            Privacy()
                                .foregroundStyle(isLightMode ? Color(.black) : Color(.white))
                    .navigationTitle("Settings")
                }
            }
            }
        }
    }

struct RateTheApp: View {
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        
        Button(action: {
            requestReview()
        }, label: {
            HStack {
                Image(systemName: "star.bubble")
                Text("Rate the app")
                    .font(.title3)
            }
        })
    }
}

struct Recommend: View {
    var body: some View {
                
                ShareLink(item: URL(string: "https://apps.apple.com/tr/app/jurassic-journey/id6477622649")!) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Recommend the app")
                            .font(.title3)
                    }
                }
            }
        }

struct Feedback: View {
    var body: some View {
        
        let email = "alperensarisan@icloud.com"
        
        Button(action: {
            
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                }
            } else {
                
            }
        }, label: {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Submit Feedback")
                    .font(.title3)
            }
        })
        
    }
}

struct Privacy: View {
    var body: some View {
            
            Link(destination: URL(string: "https://www.termsfeed.com/live/f36c5210-fdf6-4db5-837b-c379992471b5")!, label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Privacy Policy")
                        .font(.title3)
            }
    })
}
                 }

#Preview {
    OptionScreen()
        .preferredColorScheme(.dark)
}
