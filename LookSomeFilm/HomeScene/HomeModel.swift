//
//  HomeModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

enum HomeSectionType {
    case popular([Result])
    case upcoming([Result])
    case topRated([Result])
    case nowPlaying([Result])
}

struct HomeModel {
    var section: HomeSectionType
    var title: String
}
