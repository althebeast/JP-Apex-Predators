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
            ScrollView {
                PredatorCardView(predator: bookmarkVm.bookmarks)
                    .navigationTitle("Favorite Dinos")
            }
            .overlay(overlayView(isEmpty: bookmarkVm.bookmarks.isEmpty))
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
}
