//
//  FavouriteModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import Foundation
import RealmSwift

final class FavouriteModel: Object {
    @Persisted var id: Int?
    @Persisted var overview: String?
    @Persisted var posterPath: String?
    @Persisted var releaseDate: String?
    @Persisted var title: String?
    @Persisted var voteAverage: Double?

    convenience init(id: Int? = nil, overview: String? = nil, posterPath: String? = nil, releaseDate: String? = nil, title: String? = nil, voteAverage: Double? = nil) {
        self.init()
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }
}
