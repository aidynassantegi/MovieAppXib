//
//  ViewController.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 02.06.2022.
//

import UIKit

var allGenres: [Genre] = []

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let sectionTitles = ["Now Playing", "Upcomming", "Top Rated"]
    
    private var networkManager = NetworkManagerAF.shared
    
    private var genres: [Genre] = [] {
        didSet {
            allGenres = genres
            tableView.reloadData()
        }
    }
    private var movies: [[Movie]] = [[],[],[]] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle(for: MainTableViewCell.self)), forCellReuseIdentifier: "MainTableViewCell")
        loadGenres()
        loadMovies()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, TapDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.sectionTitleLabel.text = sectionTitles[indexPath.row]
        cell.changeMovies(movies: movies[indexPath.row], indexPathRow: indexPath.row)
        cell.tapDelegate = self
        return cell
    }
    func showAllMovies(at section: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllViewController") as! AllViewController
        vc.movies = movies[section]
        vc.title = sectionTitles[section]
        navigationController?.pushViewController(vc, animated: true)
    }
    func showMovieInfo(at section: Int, index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        vc.setupView(movie: movies[section][index])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController {
    func loadGenres() {
        networkManager.loadGenres { [weak self] genres in
            self?.genres = genres
        }
    }
    func loadMovies() {
        networkManager.loadNowPlaying { [weak self] movies in
            self?.movies[0] = movies.shuffled()
        }
        networkManager.loadPopular { [weak self] movies in
            self?.movies[1] = movies.shuffled()
        }
        networkManager.loadTopRated { [weak self] movies in
            self?.movies[2] = movies.shuffled()
        }
        
    }
}
