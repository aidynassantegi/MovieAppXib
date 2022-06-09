//
//  NetworkManagerAF.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 08.06.2022.
//

import Foundation
import Alamofire

class NetworkManagerAF {
    private let API_KEY = "e516e695b99f3043f08979ed2241b3db"
    static var shared = NetworkManagerAF()
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY)]
        return components
    }()
    
    func loadGenres(completion: @escaping ([Genre]) -> Void) {
        var components = urlComponents
        components.path = "/3/genre/movie/list"
        
        guard let requestUrl = components.url else { return }
        
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let genresEntity = try JSONDecoder().decode(GenresEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(genresEntity.genres)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            case .failure(let error):
                print("Error occured", error)
            }
        }
    }
    private func loadMovies(path: String, completion: @escaping ([Movie]) -> Void) {
        var components = urlComponents
        components.path = path
        
        guard let requestUrl = components.url else { return }
        
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let moviesEntity = try JSONDecoder().decode(MoviesEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesEntity.results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            case .failure(let error):
                print("Error occured", error)
            }
        }
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
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let castEntity = try JSONDecoder().decode(CastEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(castEntity.cast)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            case .failure(let error):
                print("Error occured", error)
            }
        }
    }
    
    func loadPeople(personId: Int, completion: @escaping (People) -> Void) {
        var components = urlComponents
        components.path = "/3/person/\(personId)"
        //print(components.url)
        guard let requestUrl = components.url else {
            return
        }
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let people = try JSONDecoder().decode(People.self, from: data)
                    DispatchQueue.main.async {
                        completion(people)
                    }
                } catch {
                    
                }
            case .failure(let error):
                print("Error occured", error)
            }
        }
    }
}
