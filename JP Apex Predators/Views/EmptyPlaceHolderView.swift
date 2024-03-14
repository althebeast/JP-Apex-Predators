//
//  EmptyPlaceHolderView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct EmptyPlaceHolderView: View {
    
    let text: String
    let image: Image
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            Image(systemName: "star")
                    .imageScale(.large)
                    .font(.system(size: 52))
            
            
            Text(text)
                .fontWeight(.semibold)
                .font(.headline)
            
        
            Spacer()
        }
    }
}

#Preview {
    EmptyPlaceHolderView(text: "hello", image: Image(systemName: "star"))
}
