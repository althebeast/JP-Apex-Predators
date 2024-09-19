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
        VStack (spacing: 20) {
            
            Spacer()
            
            Image(systemName: "star")
                .renderingMode(.template)
                .foregroundStyle(bookmarkVm.animate ? bookmarkVm.secondColor : bookmarkVm.firstColor)
                .font(.system(size: 120))
                .shadow(color: bookmarkVm.animate ? Color.white.opacity(0.7) : bookmarkVm.secondColor.opacity(0.7),
                        radius: bookmarkVm.animate ? 30 : 10,
                        x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                        y: bookmarkVm.animate ? -50 : 30)
                .scaleEffect(bookmarkVm.animate ? 1.3 : 1.0)
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
