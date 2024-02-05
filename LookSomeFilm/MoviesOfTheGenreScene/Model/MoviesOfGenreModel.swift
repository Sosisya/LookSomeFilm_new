//
//  MoviesOfGenreModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 07.12.2023.
//

import Foundation

struct MoviesOfGenre: Decodable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
