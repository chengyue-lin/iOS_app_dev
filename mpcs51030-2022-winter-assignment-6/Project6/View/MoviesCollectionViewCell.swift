//
//  MoviesCollectionViewCell.swift
//  Project6
//
//  Created for MPCS 501030
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    
    func setTitleLabel(_ name: String){
        titleLabel.text = name
        titleLabel.textColor = .white
    }
    func setPriceLabel(_ price: String){
        priceLabel.text = price
        priceLabel.textColor = .white
    }
    func setRatingLabel(_ rate: String){
        ratingLabel.text = rate
        ratingLabel.textColor = .white
    }
    func setImageView(_ imageVi: UIImage){
        imageView.image = imageVi
    }
   
}
