//
//  APIEndpoints.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Foundation

enum APIEndpoints: String {
    case trendingMovies = "https://api.themoviedb.org/3/trending/movie/day?api_key=1142a99bf07976137aa26eec0caaa30e"
    
    var url: URL {
        URL(string: self.rawValue)!
    }
}
