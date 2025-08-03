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
        HStack(spacing: 16) {
            // Image with soft shadow and rounded corners
            Image(predator.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(predator.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(predator.type.rawValue.capitalized)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(predator.type.background.opacity(0.3))
                    .foregroundStyle(predator.type.background)
                    .clipShape(Capsule())
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(.systemGray6).opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
