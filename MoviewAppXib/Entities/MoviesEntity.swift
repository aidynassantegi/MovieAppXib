//
//  MoviesEntity.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 02.06.2022.
//

import Foundation


struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
    
    let id: Int
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double
    let posterUrl: String?
    let genreIds: [Int]
    let overview: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originalTitle = try? container.decodeIfPresent(String.self, forKey: .originalTitle)
        releaseDate = try? container.decodeIfPresent(String.self, forKey: .releaseDate)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        if let posterPath = try? container.decodeIfPresent(String.self, forKey: .posterPath) {
            posterUrl = "https://image.tmdb.org/t/p/w200\(posterPath)"
        } else { posterUrl = nil }
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        overview = try? container.decode(String.self, forKey: .overview)
    }
}

struct MoviesEntity: Decodable {
    let results: [Movie]
}
