//
//  UpcomingModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 19.11.2023.
//

import Foundation

struct Upcoming: Decodable {
    let dates: Dates?
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
