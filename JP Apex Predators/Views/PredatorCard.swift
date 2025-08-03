//
//  PredatorCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 7.02.2024.
//

import SwiftUI

struct PredatorCard: View {
    let predator: ApexPredator
    @Environment(BookmarkViewModel.self) var bookmarkVm
    @State private var isPressed: Bool = false
    
    var body: some View {
        NavigationLink(destination: PredatorDetail(predator: predator, position: .automatic)) {
            ZStack {
                // Background Gradient with layered colorful shadows
                LinearGradient(colors: predator.type.gradientColors,
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .cornerRadius(20)
                    // Base strong black shadow
                    .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 8)
                    // Dark eerie green glow
                    .shadow(color: Color(red: 0, green: 0.3, blue: 0, opacity: 0.3), radius: 14, x: -6, y: 0)
                    // Subtle blood-red glow
                    .shadow(color: Color(red: 0.4, green: 0, blue: 0, opacity: 0.2), radius: 16, x: 6, y: 6)
                    // Dim highlight shadow
                    .shadow(color: Color.white.opacity(0.05), radius: 6, x: -3, y: -3)
                    .overlay(
                        // Light reflection effect
                        LinearGradient(colors: [Color.white.opacity(0.15), Color.clear],
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .blendMode(.overlay)
                            .cornerRadius(20)
                    )
                    .rotation3DEffect(
                        .degrees(isPressed ? 8 : 0),
                        axis: (x: 1, y: 1, z: 0)
                    )
                
                VStack(spacing: 12) {
                    Spacer()
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        .scaleEffect(isPressed ? 1.05 : 1)
                        .rotation3DEffect(
                            .degrees(isPressed ? 10 : 0),
                            axis: (x: 0.5, y: -0.5, z: 0)
                        )
                        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isPressed)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(predator.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(predator.type.rawValue.capitalized)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(predator.type.background)
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .frame(height: 300)
            .padding()
        }
        .buttonStyle(PlainButtonStyle()) // Remove default blue highlight
        // Animate the press effect on long press
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.1).onChanged { _ in
                withAnimation {
                    isPressed = true
                }
            }.onEnded { _ in
                withAnimation {
                    isPressed = false
                }
            }
        )
    }
}

extension PredatorType {
    var gradientColors: [Color] {
        switch self {
        case .land:
            // Dark forest green to deep brown
            return [Color(red: 0.05, green: 0.15, blue: 0.05), Color(red: 0.2, green: 0.1, blue: 0.05)]
        case .air:
            // Dark stormy blue to near black
            return [Color(red: 0.05, green: 0.1, blue: 0.2), Color.black.opacity(0.85)]
        case .sea:
            // Deep teal to navy black
            return [Color(red: 0, green: 0.1, blue: 0.1), Color.black.opacity(0.9)]
        default:
            return [Color.black.opacity(0.7), Color.black]
        }
    }
}

#Preview {
    NavigationView {
        PredatorCard(predator: PredatorController().apexPredators[0])
            .environment(BookmarkViewModel())
            .preferredColorScheme(.dark)
    }
}
