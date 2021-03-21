//
//  MovieListViewModel.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import Foundation

enum MovieFilter: Int {
    case all
    case topRated
    case favorite
}

final class MovieListViewModel: ViewModel {
    
    private let apiManager = APIManager()
    
    @Published private var movies = [MovieDetailViewModel]()
    @Published private(set) var filteredMovies = [MovieDetailViewModel]()
    @Published var selectedFilterIndex: MovieFilter = .all
    private(set) var error = PassthroughSubject<Error, Never>()
    
    func fetchMovieList() {
        let url = APIEndpoints.trendingMovies.url
        apiManager.fetchData(with: url) { [weak self] (response: Result<MovieListResponse, Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let response):
                self.movies = response.results.map { MovieDetailViewModel(movie: $0) }
                self.filteredMovies = self.movies
            case .failure(let error):
                self.movies.removeAll()
                self.filteredMovies.removeAll()
                self.error.send(error)
            }
        }
    }
    
    func applyFilter(with filterType: MovieFilter = .all) {
        selectedFilterIndex = filterType
        
        switch filterType {
        case .all:
            filteredMovies = movies
        case .topRated:
            filteredMovies = movies.filter({
                $0.rating >= 4.0
            })
        case .favorite:
            filteredMovies = movies.filter({
                $0.isFavorite
            })
        }
    }
    
    func checkActiveSegment() {
        if selectedFilterIndex == .favorite {
            applyFilter(with: .favorite) /// Reload table if active tab is favorite
        }
    }
    
    func getCellViewModel(for index: Int) -> MovieDetailViewModel {
        filteredMovies[index]
    }
}
