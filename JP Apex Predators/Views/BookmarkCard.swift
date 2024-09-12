//
//  BookmarkCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct BookmarkCard: View {
    
    @Environment (BookmarkViewModel.self) var bookmarkVm
    
    var body: some View {
        NavigationStack {
                ZStack {
                    if bookmarkVm.bookmarks.isEmpty {
                        NoBookmarkView()
                            .transition(AnyTransition.opacity.animation(.easeIn))
                    } else {
                        ScrollView {
                        PredatorCardView(predator: bookmarkVm.bookmarks)
                    }
                        .scrollIndicators(.hidden)
                }
                    
            }
            .navigationTitle("Favorite Dinos")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            VStack {
                EmptyPlaceHolderView(text: "There's nothing 😔", image: Image(systemName: "star"))
            }
        }
    }
}

#Preview {
    BookmarkCard()
        .environmentObject(BookmarkViewModel())
        .preferredColorScheme(.dark)
}
