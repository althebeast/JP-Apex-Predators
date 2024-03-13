//
//  BookmarkViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 13.03.2024.
//

import SwiftUI

@Observable
class BookmarkViewModel: ObservableObject {
    
    private(set) var bookmarks: [ApexPredator] = []
    
    func isBookmarked(for apex: ApexPredator) -> Bool {
        bookmarks.first { apex.id == $0.id } != nil
    }
    
    func addBookmark(for apex: ApexPredator) {
        guard !isBookmarked(for: apex) else {
            return
        }
        
        bookmarks.insert(apex, at: 0)
    }
    
    func removeBookmark(for apex: ApexPredator) {
        guard let index = bookmarks.firstIndex(where: { $0.id == apex.id }) else {
            return
        }
        bookmarks.remove(at: index)
    }
}
