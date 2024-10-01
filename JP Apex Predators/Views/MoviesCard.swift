//
//  MoviesCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import SwiftUI
import CachedAsyncImage

struct MoviesCard: View {
    
    @Environment(MovieViewModel.self) var movievm
    
    @State var selectedImage: Part?
    
    var newDate:DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        
        return dateFormatter
    }
    
    var body: some View {
        
        @Bindable var vm = MovieViewModel()
        
        GeometryReader { geo in
        NavigationView {
            ZStack {
                
                if !movievm.isInternetAvailable() {
                    NoMoviesView(firstTitle: "Looks like there's a problem with your connection 🧐",
                                 buttonTitle: "Try Again")
                    .transition(.asymmetric(
                        insertion: AnyTransition.opacity.animation(.easeIn),
                        removal: .move(edge: .leading)))
                } else {
                    VStack(spacing: 0) {
                            List(movievm.parts) { part in
                                VStack {
                                    
                                    CachedAsyncImage(url: part.imageURL) { image in
                                        switch image {
                                        case .empty:
                                            HStack {
                                                Spacer()
                                                ProgressView()
                                                Spacer()
                                            }
                                        case .success(let image):
                                            if geo.size.height > 1000 || geo.size.width > geo.size.height {
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: geo.size.height/1.5)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                            } else {
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                            }
                                        case .failure:
                                            HStack {
                                                Spacer()
                                                Image(systemName: "photo")
                                                    .imageScale(.large)
                                                Spacer()
                                            }
                                        @unknown default:
                                            fatalError()
                                        }
                                    }
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        selectedImage = part
                                    }
                                    
                                    HStack {
                                        Text(part.title)
                                            .font(.title2)
                                            .bold()
                                        .padding(.bottom, 10)
                                        
                                        Spacer()
                                    }
                                    
                                    Text(part.overview)
                                        .padding(.bottom, 10)
                                        .font(.subheadline)
                                    
                                    HStack {
                                        Text("Rating: \(part.voteAverage, specifier: "%.1f")")
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()

                                        Text("Release Date: \(newDate.string(from: part.releaseDate))")
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .padding(.bottom, 10)
                                    Divider()
                                        .padding(.bottom, 10)
                                }
                                .padding(.horizontal)
                                .multilineTextAlignment(.leading)
                                .listRowSeparator(.hidden)
                            }
                            .scrollIndicators(.hidden)
                            .listStyle(.plain)
                            .refreshable {
                                movievm.fetcData()
                            }
                        }
                }
            }
            .onAppear {
                movievm.fetcData()
            }
            .navigationTitle("Jurassic Park Movies")
            }
        }
        .navigationViewStyle(.stack)
        .sheet(item: $selectedImage) { j in
            MovieImageSheetView(imageToShow: j)
        }
    }
}

#Preview {
    MoviesCard()
        .environment(MovieViewModel())
        .preferredColorScheme(.dark)
}
