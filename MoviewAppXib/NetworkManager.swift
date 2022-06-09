//
//  NetworkManager.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 02.06.2022.
//

import Foundation

class NetworkManager {
    private let API_KEY = "e516e695b99f3043f08979ed2241b3db"
    static var shared = NetworkManager()

    private let session: URLSession
    var imagesCache = NSCache<NSString, NSData>()

    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        return components
    }()

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func loadGenres(completion: @escaping ([Genre]) -> Void) {
        var components = urlComponents
        components.path = "/3/genre/movie/list"

        guard let requestUrl = components.url else {
            return
        }

        let task = session.dataTask(with: requestUrl) { data, responce, error in

            guard error == nil else {
                print("Error: error calling GET")
                return
            }

            guard let data = data else {
                print("Error: Did not recieve data")
                return
            }

            guard let responce = responce as? HTTPURLResponse, (200..<300) ~= responce.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            do {
                let genresEntity = try JSONDecoder().decode(GenresEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(genresEntity.genres)
                }
            }catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
    
    

    private func loadMovies(path: String, completion: @escaping ([Movie]) -> Void) {
        var components = urlComponents
        components.path = path

        guard let requestUrl = components.url else {
            return
        }
        
        let task = session.dataTask(with: requestUrl) { data, responce, error in

            guard error == nil else {
                print("Error: error calling GET")
                return
            }

            guard let data = data else {
                print("Error: Did not recieve data")
                return
            }

            guard let responce = responce as? HTTPURLResponse, (200..<300) ~= responce.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            do {
                let moviesEntity = try JSONDecoder().decode(MoviesEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(moviesEntity.results)
                }
            }catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }

    func loadNowPlaying(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/movie/now_playing") { movies in
            completion(movies)
        }
    }
    func loadPopular(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/movie/popular") { movies in
            completion(movies)
        }
    }
    func loadTopRated(completion: @escaping ([Movie]) -> Void) {
        loadMovies(path: "/3/movie/top_rated") { movies in
            completion(movies)
        }
    }
    
    func loadCredits(movieID: Int, completion: @escaping ([Cast]) -> Void) {
        var components = urlComponents
        components.path = "/3/movie/\(movieID)/credits"
        //print(components.url)
        guard let requestUrl = components.url else {
            return
        }
        print(requestUrl)
        let task = session.dataTask(with: requestUrl) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive cast data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request for cast failed")
                return
            }
            do {
                let creditsEntity = try JSONDecoder().decode(CastEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(creditsEntity.cast)
                }
            }catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
    
    func loadPeople(personId: Int, completion: @escaping (People) -> Void) {
        var components = urlComponents
        components.path = "/3/person/\(personId)"
        //print(components.url)
        guard let requestUrl = components.url else {
            return
        }
        print(requestUrl)
        let task = session.dataTask(with: requestUrl) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive cast data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request for cast failed")
                return
            }
            do {
                let people = try JSONDecoder().decode(People.self, from: data)
                DispatchQueue.main.async {
                    completion(people)
                }
            }catch {
                DispatchQueue.main.async {
                    print("No person information")
                }
            }
        }
        task.resume()
    }
}
