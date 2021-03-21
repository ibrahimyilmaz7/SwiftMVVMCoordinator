//
//  MovieListResponse.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
