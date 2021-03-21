//
//  StarRating.swift
//  SwiftMVVMCoordinator
//
//  Created by ibrahimyilmaz on 20.03.2021.
//

import Foundation
import UIKit

final class StarRating: UIStackView {
    
    private let star = "star"
    private let starHalfFill = "star.lefthalf.fill"
    private let starFill = "star.fill"
    private let halfFillRoundBuffer: Double = 0.5
    private let spaceBetweenCells: CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = spaceBetweenCells
    }
    
    func setValue(value: Double = 0, max: Int = 5) {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for index in 1...max {
            let image = UIImage(systemName: getIcon(index: Double(index), value: value))
            let imageView = UIImageView(image: image)
            imageView.tintColor = .systemYellow
            
            imageView.heightAnchor.constraint(
                equalTo: imageView.widthAnchor,
                multiplier: 1.0
            ).isActive = true
            
            addArrangedSubview(imageView)
        }
    }
    
    private func getIcon(index: Double, value: Double) -> String {
        switch index {
        case 0...value:
            return starFill
        case value...(value + halfFillRoundBuffer):
            return starHalfFill
        default:
            return star
        }
    }
}
