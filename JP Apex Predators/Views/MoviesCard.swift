//
//  MoviesCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import SwiftUI
import CachedAsyncImage

struct MoviesCard: View {
    @Environment(MoviesViewModel.self) var movievm
    @State var selectedImage: Part?

    var newDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    var body: some View {
        NavigationView {
            ZStack {
                if !movievm.isInternetAvailable() {
                    NoMoviesView(
                        firstTitle: "Looks like there's a problem with your connection 🧐",
                        buttonTitle: "Try Again"
                    )
                    .transition(.opacity.combined(with: .scale))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(movievm.movies) { part in
                                MoviePosterCard(part: part) {
                                    selectedImage = part
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .scrollIndicators(.hidden)
                    .refreshable {
                        await movievm.fetchData()
                    }
                }
            }
            .onAppear {
                Task {
                    await movievm.fetchData()
                }
            }
            .refreshable {
                await movievm.fetchData()
            }
            .navigationTitle("Jurassic Park Movies")
        }
        .navigationViewStyle(.stack)
        .sheet(item: $selectedImage) { part in
            MovieImageSheetView(imageToShow: part)
        }
    }
}

struct MoviePosterCard: View {
    let part: Part
    var onTap: () -> Void

    var newDate: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                // Poster Image
                CachedAsyncImage(url: part.imageURL) { image in
                    switch image {
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.3)
                            ProgressView()
                        }
                    case .success(let img):
                        img
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            .overlay(
                                LinearGradient(
                                    colors: [.black.opacity(0.8), .clear],
                                    startPoint: .bottom,
                                    endPoint: .center
                                )
                            )
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)

                // Text overlay
                VStack(alignment: .leading, spacing: 6) {
                    Text(part.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    HStack(spacing: 12) {
                        RatingBadge(rating: part.imdbRating)
                        Text(newDate.string(from: part.released))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                    }
                }
                .padding()
            }
            .onTapGesture {
                onTap()
            }
        }
        .padding(.horizontal)
    }
}

struct RatingBadge: View {
    let rating: Double

    var body: some View {
        Text(String(format: "%.1f", rating))
            .font(.caption.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .foregroundColor(.black)
            .shadow(radius: 2)
    }
}
