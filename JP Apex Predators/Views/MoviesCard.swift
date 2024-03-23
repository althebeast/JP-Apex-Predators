//
//  MoviesCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import SwiftUI
import CachedAsyncImage

struct MoviesCard: View {
    
    @Environment (MovieViewModel.self) var movievm
    
    var body: some View {
        
        @Bindable var vm = MovieViewModel()
        
        NavigationView {
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
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
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
                            
                            Text("Release Date: \(part.releaseDate)")
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
                
                .listStyle(.plain)
                .refreshable {
                    movievm.fetcData()
                }
            }
            .onAppear {
                movievm.fetcData()
            }
            .navigationTitle("Jurassic Park Movies")
        }
    }
}

#Preview {
    MoviesCard()
        .environmentObject(MovieViewModel())
        .preferredColorScheme(.dark)
}
