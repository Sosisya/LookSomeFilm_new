//
//  MovieDetailsPresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol MovieDetailsPresenterProtocol: AnyObject {
    func presentData(movieDetails: MovieDetails?, castAndCrew: CastAndCrew?)
    func presentError()
}

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {

    var view: MovieDetailsViewProtocol?
    var model: [MovieDetailsModel] = []

    func presentData(movieDetails: MovieDetails?, castAndCrew: CastAndCrew?) {
        if let movieDetailsResult = movieDetails {
            model.append(MovieDetailsModel(section: .details(movieDetailsResult), title: "MovieDetails"))
        }

        model.append(MovieDetailsModel(section: .footer, title: "Header"))

        if let castAndCrewResult = castAndCrew?.cast {
            model.append(MovieDetailsModel(section: .castAndCrew(castAndCrewResult), title: "Cast and crew"))
        }
        view?.displayData(viewModel: model)
    }

    
    func presentError() {
        view?.displayError()
    }
}
