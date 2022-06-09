//
//  MovieInfoViewController.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 05.06.2022.
//

import UIKit

class MovieInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var theMovie: Movie?
    private var movieImage: UIImage?
    private var casts: [Cast]? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImageView.kf.setImage(with: URL(string: theMovie?.posterUrl ?? ""))

        if let theMovie = theMovie {
            movieTitleLabel.text = theMovie.originalTitle
            overviewLabel.text = theMovie.overview ?? ""
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: Bundle(for: CastCollectionViewCell.self)), forCellWithReuseIdentifier: "CastCollectionViewCell")
    }

    func setupView(movie: Movie) {
        theMovie = movie
        NetworkManagerAF.shared.loadCredits(movieID: movie.id) { [weak self] casts in
            self?.casts = casts
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        casts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        if let casts = casts {
            cell.setup(cast: casts[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        if let casts = casts {
            vc.setup(personId: casts[indexPath.row].id)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
