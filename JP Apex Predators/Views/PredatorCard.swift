//
//  PredatorCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 7.02.2024.
//

import SwiftUI

struct PredatorCard: View {
    
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
}

#Preview {
    PredatorRow(predator: PredatorController().apexPredators[2])
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
}
