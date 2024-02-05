//
//  GenresRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.01.2024.
//

import UIKit

protocol GenresRouterProtocol: AnyObject {
    func presentMovieSet(id: Int?, title: String?)
}

final class GenresRouter: GenresRouterProtocol {
    weak var viewController: GenresController?

    func presentMovieSet(id: Int?, title: String?) {
        let scene = MoviesOfTheGenreBuilder.build(id: id, title: title)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .fullScreen
        viewController?.present(scene, animated: true)
    }
}
