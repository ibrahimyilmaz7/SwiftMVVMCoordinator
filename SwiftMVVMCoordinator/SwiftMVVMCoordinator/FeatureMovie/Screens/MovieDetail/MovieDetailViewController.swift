//
//  MovieDetailViewController.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import UIKit

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    // MARK: Outlets
    @IBOutlet private weak var imageViewMovie: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelPrice: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var buttonFavorite: UIButton!
    @IBOutlet private weak var starRatingView: StarRating!
    
    // MARK: Variables
    var footerLinkTapped = PassthroughSubject<Void, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = LocalizableKey.appTitle.rawValue.localized()
        
        setupViews()
    }
    
    private func setupViews() {
        setupMovieInfoTopArea()
        setupMovieInfoBottomArea()
    }
    
    private func setupMovieInfoTopArea() {
        labelName.text = viewModel.name
        labelDate?.text = viewModel.releaseDate
        labelPrice?.text = viewModel.price
        
        starRatingView.setValue(value: viewModel.rating)
        
        imageViewMovie.kf.setImage(with: viewModel.imageURL)
    }
    
    private func setupMovieInfoBottomArea() {
        labelDescription.text = viewModel.description
        
        checkFavorite()
    }
    
    private func checkFavorite() {
        buttonFavorite.isSelected = viewModel.isFavorite
        labelName.textColor = viewModel.isFavorite ? .systemBlue : .label
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        viewModel.isFavorite.toggle()
        
        checkFavorite()
    }
}
