//
//  MovieViewModel.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 22.03.2024.
//

import Foundation
import Network
import Observation
import SwiftUI

@Observable
class MoviesViewModel {
    var movies: [Part] = []
    var isLoading = false
    var errorMessage: String?
    var animate = false
    
    var firstColor: Color = .blue
    var secondColor: Color = .green
    
    private let service = MovieService()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetMonitor")
    private var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    func isInternetAvailable() -> Bool {
        return isConnected
    }

    func fetchData() async {
        guard isInternetAvailable() else {
            errorMessage = "No internet connection."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let titles = [
            "Jurassic Park",
            "The Lost World: Jurassic Park",
            "Jurassic Park III",
            "Jurassic World",
            "Jurassic World: Fallen Kingdom",
            "Jurassic World Dominion"
        ]
        
        var loadedMovies: [Part] = []
        
        for title in titles {
            do {
                let movie = try await service.fetchMovie(byTitle: title)
                loadedMovies.append(movie)
            } catch {
                errorMessage = "Failed to load \(title): \(error.localizedDescription)"
            }
        }
        
        self.movies = loadedMovies
        isLoading = false
    }
}
