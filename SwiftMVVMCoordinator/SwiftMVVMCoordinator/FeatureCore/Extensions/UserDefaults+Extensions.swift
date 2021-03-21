//
//  UserDefaults+Extensions.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Foundation

extension UserDefaults {
    public enum Keys: String {
        case isFavorite = "is_movie_favorite"
        
        func build(with id: Int) -> String {
            self.rawValue + "_\(id)"
        }
    }
    
    func isMovieFavorite(_ id: Int) -> Bool {
        return bool(forKey: Keys.isFavorite.build(with: id))
    }
    
    func setMovieFavorite(_ id: Int, _ value: Bool) {
        set(value, forKey: Keys.isFavorite.build(with: id))
    }
}
