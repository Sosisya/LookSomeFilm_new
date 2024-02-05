//
//  CastAndCrewPresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol CastAndCrewPresenterProtocol: AnyObject {
    func presentData(response: CastAndCrew?)
    func presentError()
}

final class CastAndCrewPresenter: CastAndCrewPresenterProtocol {

    var view: CastAndCrewViewProtocol?
    var model: [CastAndCrewModel] = []

    func presentData(response: CastAndCrew?) {
        if let cast = response?.cast {
            model.append(CastAndCrewModel(section: .cast(cast)))
        }

        if let crew = response?.crew {
            model.append(CastAndCrewModel(section: .crew(crew)))
        }
        view?.displayCastAndCrew(viewModel: model)
    }
    
    func presentError() {
        view?.displayError()
    }
}
