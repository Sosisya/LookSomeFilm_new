//
//  MovieDetailsModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 23.01.2024.
//

import Foundation

enum MovieDetailsSectionType {
    case details(MovieDetails)
    case footer
    case castAndCrew([Cast])
}

struct MovieDetailsModel {
    var section: MovieDetailsSectionType
    var title: String
}
