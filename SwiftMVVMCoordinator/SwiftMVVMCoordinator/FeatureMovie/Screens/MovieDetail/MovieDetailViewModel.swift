//
//  MovieDetailViewModel.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import Foundation

final class MovieDetailViewModel: ViewModel {
    
    private var subscribers = Set<AnyCancellable>()
    
    let id: Int
    let name: String
    let releaseDate: String
    let description: String
    let longDescription: String
    let price: String
    let rating: Double
    let available: Bool
    let imageURL: URL?
    
    @Published var isFavorite: Bool = false
    
    init(movie: Movie) {
        self.id = movie.id
        self.name = movie.title
        self.releaseDate = "" // movie.releaseDate.formatted()
        self.description = String("\(movie.overview.prefix(50))...")
        self.longDescription = movie.overview
        self.price = String(movie.popularity)
        self.rating = movie.voteAverage / 2
        self.available = true // movie.available
        self.imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        
        isFavorite = UserDefaults.standard.isMovieFavorite(id)
        
        $isFavorite.sink { [weak self] (newValue) in
            guard let self = self else { return }
            
            UserDefaults.standard.setMovieFavorite(self.id, newValue)
        }.store(in: &subscribers)
    }
}
