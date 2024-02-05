//
//  MovieDetailsRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

protocol MovieDetailsRouterProtocol: AnyObject {
    func presentAllCrew(id: Int?)
    func dismissScene()
}

final class MovieDetailsRouter: MovieDetailsRouterProtocol {

    weak var viewController: UIViewController?

    func presentAllCrew(id: Int?) {
        let scene = CastAndCrewBuilder.build(id: id)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .fullScreen
        viewController?.present(scene, animated: true)
    }

    func dismissScene() {
        viewController?.dismiss(animated: true)
    }
}
