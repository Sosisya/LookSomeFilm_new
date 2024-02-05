//
//  FavouritePresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import Foundation

protocol FavouritePresenterProtocol: AnyObject {
    func presentData(data: [FavouriteModel])
    func presentError()
}

final class FavouritePresenter: FavouritePresenterProtocol {

    var view: FavouriteViewProtocol?

    func presentData(data: [FavouriteModel]) {
        view?.displayData(data: data)
    }

    func presentError() {
        view?.displayError()
    }
}
