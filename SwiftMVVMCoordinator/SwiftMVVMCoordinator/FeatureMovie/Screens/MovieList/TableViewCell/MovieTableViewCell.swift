//
//  MovieTableViewCell.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Combine
import Kingfisher
import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    private var subscribers = Set<AnyCancellable>()
    
    static let reuseIdentifier = "reuseIdentifierMovieTableCell"
    static let reuseIdentifierUnavailable = "reuseIdentifierMovieTableUnavailableCell"
    static let nibName = "MovieTableViewCell"
    
    // MARK: Outlets
    @IBOutlet private weak var imageViewMovie: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelDate: UILabel?
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelPrice: UILabel?
    @IBOutlet private weak var starRatingView: StarRating!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: MovieDetailViewModel) {
        labelName.text = viewModel.name
        labelDate?.text = viewModel.releaseDate
        labelDescription.text = viewModel.description
        labelPrice?.text = viewModel.price
        
        starRatingView.setValue(value: viewModel.rating)
        
        imageViewMovie.kf.setImage(with: viewModel.imageURL)
        
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (newValue) in
                self?.labelName.textColor = newValue ? .systemBlue : .label
            }.store(in: &subscribers)
    }
    
    override func prepareForReuse() {
        labelName.textColor = .label
    }
}
