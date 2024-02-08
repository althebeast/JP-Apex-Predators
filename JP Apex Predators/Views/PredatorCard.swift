//
//  PredatorCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 7.02.2024.
//

import SwiftUI

struct PredatorCard: View {
    
    var predator: ApexPredator
    
    var body: some View {
        ZStack {
            Rectangle()
                .background {
                    Image(predator.type.rawValue)
                        .resizable()
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
