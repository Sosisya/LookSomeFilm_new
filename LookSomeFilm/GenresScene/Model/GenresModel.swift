//
//  GenresModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 19.11.2023.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]?
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
}
