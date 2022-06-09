//
//  CastEntity.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 05.06.2022.
//

import Foundation

struct Cast: Decodable {
    enum CodingKeys: String, CodingKey {
        case role = "known_for_department"
        case name = "original_name"
        case id
        case profilePath = "profile_path"
    }
    
    let id: Int
    let role: String?
    let name: String?
    let profilePathUrl: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        role = try? container.decodeIfPresent(String.self, forKey: .role)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        if let profilePath = try? container.decodeIfPresent(String.self, forKey: .profilePath) {
            profilePathUrl = "https://image.tmdb.org/t/p/w200\(profilePath)"
        }else { profilePathUrl = nil }
    }
}



struct CastEntity: Decodable {
    let cast: [Cast]
}
