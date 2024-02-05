//
//  FavouriteRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import UIKit

protocol FavouriteRouterProtocol: AnyObject {
    func presentMovieDetails(id: Int?)
}

final class FavouriteRouter: FavouriteRouterProtocol {

    weak var viewController: FavouriteViewController?

    func presentMovieDetails(id: Int?) {
        let scene = MovieDetailsBuilder.build(id: id)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .fullScreen
        viewController?.present(scene, animated: true)
    }
}


