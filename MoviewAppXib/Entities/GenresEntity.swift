//
//  GanresEntity.swift
//  MoviewAppXib
//
//  Created by Aidyn Assan on 04.06.2022.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenresEntity: Decodable {
    let genres: [Genre]
}
