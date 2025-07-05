//
//  PredatorCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 7.02.2024.
//

import SwiftUI

struct PredatorCard: View {
    
    @Environment(BookmarkViewModel.self) var bookmarkVm
    
    let predator: ApexPredator
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .background {
                    Image(predator.type.rawValue)
                        .resizable()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.7),
                                Gradient.Stop(color: .black, location: 1)
                            ],
                                           startPoint: .top,
                                           endPoint: .bottom)
                        }
                }
                .foregroundStyle(.clear)
                .clipShape(.rect(cornerRadius: 15))
            
            Rectangle()
                .foregroundStyle(.black)
                .opacity(0.5)
                .clipShape(.rect(cornerRadius: 15))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(predator.name)
                        .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Spacer()
                    
                    if predator.isNew {
                        Image("rebirth")
                            .resizable()
                            .frame(width: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 90))
                            .shadow(color: .white, radius: 5)
                    }
                    
                    Button(action: {
                        withAnimation {
                            toggleBookmark(for: predator)
                        }
                    }, label: {
                        Image(systemName: bookmarkVm.isBookmarked(for: predator) ? "star.fill" : "star")
                            .font(.title2)
                    })
                }
                
                Spacer()
                
                Image(predator.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(color: .white, radius: 5)
            }
            .foregroundStyle(.white)
            .padding()
        }
        .frame(height: 400)
    }
    private func toggleBookmark(for predator: ApexPredator) {
        if bookmarkVm.isBookmarked(for: predator) {
            bookmarkVm.removeBookmark(for: predator)
        } else {
            bookmarkVm.addBookmark(for: predator)
        }
    }
}

#Preview {
    PredatorRow(predator: PredatorController().apexPredators[2])
        .preferredColorScheme(.dark)
}
