//
//  AllViewController.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 03.06.2022.
//

import UIKit

class AllViewController: UIViewController {
    
    var movies: [Movie]?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AllCollectionViewCell", bundle: Bundle(for: AllCollectionViewCell.self)), forCellWithReuseIdentifier: "AllCollectionViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AllTableViewCell", bundle: Bundle(for: AllTableViewCell.self)), forCellReuseIdentifier: "AllTableViewCell")
    }
    
    

}

extension AllViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCollectionViewCell", for: indexPath) as! AllCollectionViewCell
        cell.setupView()
        cell.ganreLabel.text = allGenres[indexPath.row].name
        return cell
    }
    
    
    
}

extension AllViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        if let movies = movies {
            cell.setMovies(movie: movies[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        625
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        if let movies = movies {
            vc.setupView(movie: movies[indexPath.row])
            vc.title = movies[indexPath.row].originalTitle
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

