//
//  CastAndCrewModel.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

enum CastAndCrewModelType {
    case cast([Cast])
    case crew([Cast])
}

struct CastAndCrewModel {
    var section: CastAndCrewModelType
}
