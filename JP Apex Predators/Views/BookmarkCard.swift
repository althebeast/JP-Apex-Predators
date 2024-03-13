//
//  BookmarkCard.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

struct BookmarkCard: View {
    
    @Environment (BookmarkViewModel.self) var bookmarkVm
    @Environment (ViewModel.self) var vm
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PredatorCardView(predator: bookmarkVm.bookmarks)
                    .navigationTitle("Saved Articles")
            }
        }
    }
}

#Preview {
    BookmarkCard()
}
