//
//  GenresPresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.01.2024.
//

import Foundation

protocol GenresPresenterProtocol: AnyObject {
    func presentGenres(response: Genres?)
    func presentError()
}

final class GenresPresenter: GenresPresenterProtocol {
    var view: GenresViewProtocol?

    func presentGenres(response: Genres?) {
        if let viewModel = response?.genres {
            view?.displayGenres(viewModel: viewModel)
        }
    }

    func presentError() {
        view?.displayError()
    }
}
