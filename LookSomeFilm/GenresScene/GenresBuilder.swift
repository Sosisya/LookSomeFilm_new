//
//  GenresBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.01.2024.
//

import UIKit

final class GenresBuilder {
    static func build() -> UIViewController {

        let api = NetworkManager()

        let vc = GenresController()
        let view = GenresView()
        let interactor = GenresInteractor(api: api)
        let presenter = GenresPresenter()
        let router = GenresRouter()

        vc.view = view
        interactor.presenter = presenter
        presenter.view = view
        view.interactor = interactor
        view.router = router
        router.viewController = vc

        interactor.getGenres()

        return vc
    }
}
