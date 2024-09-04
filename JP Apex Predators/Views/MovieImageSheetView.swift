//
//  MovieImageSheetView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 4.09.2024.
//

import SwiftUI
import CachedAsyncImage

struct MovieImageSheetView: View {
    
    var imageToShow: Part
    
    var body: some View {
        CachedAsyncImage(url: imageToShow.imageURL) { image in
            image
                .image?.resizable()
                .scaledToFit()
                .ignoresSafeArea()
            }
        }
    }
