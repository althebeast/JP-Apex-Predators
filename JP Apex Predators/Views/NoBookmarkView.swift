//
//  NoBookmarkView.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 12.09.2024.
//

import SwiftUI

struct NoBookmarkView: View {
    
    @Environment(BookmarkViewModel.self) var bookmarkVm
    
    var body: some View {
        VStack (spacing: 15) {
            
            Spacer()
            
            Image("dinosaur3big")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .foregroundStyle(bookmarkVm.animate ? bookmarkVm.secondColor : bookmarkVm.firstColor)
                .shadow(color: .white,
                        radius: bookmarkVm.animate ? 5 : 15)
                .scaleEffect(bookmarkVm.animate ? 1.1 : 1.0)
                .offset(y: bookmarkVm.animate ? -7 : 0)
            
            Text("Looks like you didn't mark any dinasours as your favorite ☹️🥺")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
            
            Text("Why don't you go and mark some dinasours as favorite so you can see your them here 🤩")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 5)
            
            Spacer()
                
        }
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !bookmarkVm.animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                bookmarkVm.animate.toggle()
            }
        }
    }
}

#Preview {
    NoBookmarkView()
        .environmentObject(BookmarkViewModel())
        .preferredColorScheme(.dark)
}
