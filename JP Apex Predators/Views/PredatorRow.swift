//
//  PredatorRow.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.01.2024.
//

import SwiftUI

struct PredatorRow: View {
    
    let predator: ApexPredator
    
    var body: some View {
        HStack{
            Image(predator.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(color: .white, radius: 1, x: 0, y: 0)
            
            VStack(alignment: .leading){
                Text(predator.name)
                    .fontWeight(.bold)
                
                Text(predator.type.rawValue.capitalized)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 5)
                    .background(predator.type.background)
                    .clipShape(.capsule)
            }
        }
    }
}

#Preview {
    PredatorRow(predator: PredatorController().apexPredators[2])
        .preferredColorScheme(.dark)
        //.previewLayout(.sizeThatFits)
}
