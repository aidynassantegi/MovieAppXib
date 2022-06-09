//
//  People.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 06.06.2022.
//

import Foundation

struct People: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, birthday, biography
        case department = "known_for_department"
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
    let name: String
    let birthday: String?
    let biography: String?
    let department: String?
    let placeOfBirth: String?
    let profilePathUrl: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        birthday = try? container.decodeIfPresent(String.self, forKey: .birthday)
        biography = try? container.decodeIfPresent(String.self, forKey: .biography)
        department = try? container.decodeIfPresent(String.self, forKey: .department)
        placeOfBirth = try? container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        if let profilePath = try? container.decodeIfPresent(String.self, forKey: .profilePath) {
            profilePathUrl = "https://image.tmdb.org/t/p/w200\(profilePath)"
        }else { profilePathUrl = nil }
    }
}
