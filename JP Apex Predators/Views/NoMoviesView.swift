//
//  NoMoviesView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 12.09.2024.
//

import SwiftUI

struct NoMoviesView: View {
    
    @Environment(MovieViewModel.self) var movievm
    
    var firstTitle: String
    var buttonTitle: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Spacer()
            
            Text(firstTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            Image("appstore")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 120))
                .padding()
                .shadow(color: .white, radius: movievm.animate ? 15 : 5)
            
            Spacer()
            
            Text("Check your connection and try again 🥳")
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundStyle(.white)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(movievm.animate ? movievm.firstColor : movievm.secondColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, movievm.animate ? 30 : 50)
            .shadow(color: movievm.animate ? movievm.firstColor.opacity(0.7) : movievm.secondColor.opacity(0.7),
                    radius: movievm.animate ? 30 : 10,
                    x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                    y: movievm.animate ? 50 : 30)
            .scaleEffect(movievm.animate ? 1.1 : 1.0)
            .offset(y: movievm.animate ? -7 : 0)
            
            Spacer()
        }
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !movievm.animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                movievm.animate.toggle()
            }
        }
    }
}

#Preview {
    NoMoviesView(firstTitle: "Looks like there's a problem with your connection 🧐", buttonTitle: "Try Again")
        .environmentObject(MovieViewModel())
        .preferredColorScheme(.dark)
}
