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
    private let bookmarkStore = PlistDataStore<[ApexPredator]>(filename: "bookmarks")
    var animate = false
    let firstColor = Color("FirstButtonColor")
    let secondColor = Color("SecondButtonColor")
    
    static let shared = BookmarkViewModel()
    init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for apex: ApexPredator) -> Bool {
        bookmarks.first { apex.id == $0.id } != nil
    }
    
    func addBookmark(for apex: ApexPredator) {
        guard !isBookmarked(for: apex) else {
            return
        }
        
        bookmarks.insert(apex, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for apex: ApexPredator) {
        guard let index = bookmarks.firstIndex(where: { $0.id == apex.id }) else {
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
}
