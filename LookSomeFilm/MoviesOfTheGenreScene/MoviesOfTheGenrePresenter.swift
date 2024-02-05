//
//  MoviesOfTheGenrePresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol  MoviesOfTheGenrePresenterProtocol: AnyObject {
    func presentData(id: Int, response: MoviesOfGenre?)
    func presentTitle(title: String)
    func presentError()
}

final class MoviesOfTheGenrePresenter: MoviesOfTheGenrePresenterProtocol {

    var view: MoviesOfTheGenreViewProtocol?

    func presentData(id: Int, response: MoviesOfGenre?) {
        guard let response = response else { return }
        view?.displayData(id: id, viewModel: response)
    }

    func presentError() {
        view?.displayError()
    }

    func presentTitle(title: String) {
        view?.displayTitle(title: title)
    }
}
