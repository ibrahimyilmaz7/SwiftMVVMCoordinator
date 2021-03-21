//
//  MovieCoordinator.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import SafariServices
import UIKit

class MovieCoordinator: Coordinator {
    
    private var subscribers = Set<AnyCancellable>()
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MovieListViewModel()
        let controller = MovieListViewController(viewModel: viewModel)
        
        /// Subscribe selectedRow for navigating to detail page when movie have selected.
        controller.selectedRowIndexPath
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                let movie = viewModel.filteredMovies[index]
                self?.showMovieDetail(for: movie)
            }.store(in: &subscribers)
        
        navigationController.pushViewController(controller, animated: false)
    }
    
    private func showMovieDetail(for movieDetailViewModel: MovieDetailViewModel) {
        let controller = MovieDetailViewController(viewModel: movieDetailViewModel)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
