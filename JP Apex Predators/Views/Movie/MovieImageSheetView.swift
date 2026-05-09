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
//                            .overlay {
//                                LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gray, location: 1)], startPoint: .top, endPoint: .bottom)
//                            }
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                HStack(spacing: 12) {
                    Text(imageToShow.title)
                        .font(.title.bold())
                    
                    RatingBadge(rating: imageToShow.imdbRating)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                }
                
                Text(imageToShow.plot)
                    .font(.title2)
                
                Text("· Director: \(imageToShow.director)")
                    .font(.title3)
                
                Text("· Genre: \(imageToShow.genre)")
                    .font(.title3)
                
                Text("· Awards: \(imageToShow.awards)")
                    .font(.title3)
                    .padding(.bottom, 20)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}
