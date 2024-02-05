//
//  MoviesOfTheGenreRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol MoviesOfTheGenreRouterProtocol: AnyObject {
    func presentMovieDetails(id: Int?)
    func goBack()
}

final class MoviesOfTheGenreRouter: MoviesOfTheGenreRouterProtocol {
    weak var viewController: MoviesOfTheGenreController?

    func presentMovieDetails(id: Int?) {
        let scene = MovieDetailsBuilder.build(id: id)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .fullScreen
        viewController?.present(scene, animated: true)
    }

    func goBack() {
        viewController?.dismiss(animated: true)
    }
}
