//
//  MovieImageSheetView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 4.09.2024.
//

import SwiftUI
import CachedAsyncImage

struct MovieImageSheetView: View {
    let imageToShow: Part
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let url = imageToShow.imageURL {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(imageToShow.title)
                    .font(.title.bold())
                
                Text(imageToShow.plot)
                    .font(.subheadline)
                
                Text("Director: \(imageToShow.director)")
                
                Text("Genre: \(imageToShow.genre)")
                
                Text("Awards: \(imageToShow.awards)")
                    .padding(.bottom, 20)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}
