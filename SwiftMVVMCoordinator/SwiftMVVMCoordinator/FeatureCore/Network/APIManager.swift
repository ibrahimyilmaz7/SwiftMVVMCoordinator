//
//  APIManager.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import Foundation

class APIManager {
    private var subscribers = Set<AnyCancellable>()
    
    func fetchData<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { (response) in
                switch response {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { (response) in
                completion(.success(response))
            }.store(in: &subscribers)
    }
}
