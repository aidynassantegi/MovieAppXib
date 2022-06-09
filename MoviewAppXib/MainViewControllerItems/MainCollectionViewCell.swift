//
//  MainCollectionViewCell.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 02.06.2022.
//

import UIKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setMovie(movie: Movie) {
        setRatingView(rating: movie.voteAverage)
        titleLabel.text = movie.originalTitle ?? ""
//        genreLabel.text = "\(movie.genreIds)"
        setGenres(ids: movie.genreIds)
        ratingBackgroundView.layer.cornerRadius = 15
        
        let url = URL(string: movie.posterUrl ?? "")
        imageView.kf.setImage(with: url)
//        NetworkManager.shared.loadImage(with: movie.posterPath ?? "", completion: {[weak self] imageData in
//            self?.imageView.image = UIImage(data: imageData)
//        })
    }
    
    private func setRatingView(rating: Double) {
        ratingLabel.textColor = .white
        ratingLabel.text = "★ \(rating)"
        ratingLabel.backgroundColor = .none
        if rating < 6 {
            ratingBackgroundView.backgroundColor = .systemRed
        }else if rating < 7 {
            ratingBackgroundView.backgroundColor = .systemPurple
        }else if rating < 8 {
            ratingBackgroundView.backgroundColor = .systemYellow
        }else if rating < 9 {
            ratingBackgroundView.backgroundColor = .systemGreen
        }else {
            ratingBackgroundView.backgroundColor = .systemBlue
        }
    }
    
    private func setGenres(ids: [Int]) {
        var genreText: String = ""
        let last = ids.last
        for i in ids {
            for genre in allGenres {
                if i == genre.id {
                    if i == last {
                        genreText += genre.name
                    }else {
                        genreText += genre.name + ", "
                    }
                }
            }
        }
        genreLabel.text = genreText
        
    }

}
