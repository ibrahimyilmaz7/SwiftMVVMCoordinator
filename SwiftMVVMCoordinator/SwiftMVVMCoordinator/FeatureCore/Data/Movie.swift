//
//  Movie.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

struct Movie: Codable {
    let id: Int
    let posterPath: String
    let video: Bool
    let title, overview, releaseDate: String
    let voteCount: Int
    let adult: Bool
    let backdropPath: String
    let voteAverage: Double
    let genreIDS: [Int]
    let originalTitle: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case video, title, overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case popularity
    }
}
