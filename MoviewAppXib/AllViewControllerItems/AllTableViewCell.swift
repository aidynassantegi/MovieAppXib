//
//  TableViewCell.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 03.06.2022.
//

import UIKit

class AllTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingBackgroundView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovies(movie: Movie) {
        setRatingView(rating: movie.voteAverage)
        movieTitleLabel.text = movie.originalTitle ?? ""
        releaseDateLabel.text = movie.releaseDate ?? ""
        movieImageView.kf.setImage(with: URL(string: movie.posterUrl ?? ""))
        movieImageView.layer.cornerRadius = 40
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
        ratingBackgroundView.layer.cornerRadius = 15
    }
}
