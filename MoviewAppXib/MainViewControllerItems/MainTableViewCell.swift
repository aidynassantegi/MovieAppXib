//
//  MainTableViewCell.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 02.06.2022.
//

import UIKit

protocol TapDelegate: AnyObject {
    func showAllMovies(at section: Int)
    func showMovieInfo(at section: Int, index: Int)
}

class MainTableViewCell: UITableViewCell {

    weak var tapDelegate: TapDelegate?
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var movies: [Movie]?
    private var indexPathRow: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: Bundle(for: MainCollectionViewCell.self)), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    @IBAction func allButton(_ sender: UIButton) {
        tapDelegate?.showAllMovies(at: indexPathRow)
    }
    
    func changeMovies(movies: [Movie], indexPathRow: Int) {
        self.movies = movies
        self.indexPathRow = indexPathRow
        collectionView.reloadData()
    }
    
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        if let movies = movies {
            cell.setMovie(movie: movies[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 310)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapDelegate?.showMovieInfo(at: indexPathRow, index: indexPath.row)
    }
    
}
