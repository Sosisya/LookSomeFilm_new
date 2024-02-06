//
//  HomeRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func presentMovieDetails(id: Int?)
    func presentAlert(alert: UIAlertController)
}

final class HomeRouter: HomeRouterProtocol {

    weak var viewController: HomeViewController?

    func presentMovieDetails(id: Int?) {
        let scene = MovieDetailsBuilder.build(id: id)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .fullScreen
        viewController?.present(scene, animated: true)
    }

    func presentAlert(alert: UIAlertController) {
        DispatchQueue.main.async {
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
}
