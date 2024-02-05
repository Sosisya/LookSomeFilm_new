//
//  MoviesOfTheGenreBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

final class MoviesOfTheGenreBuilder {
    static func build(id: Int?, title: String?) -> UIViewController {
        let api = NetworkManager()
        let realm = RealmManager()

        let vc = MoviesOfTheGenreController()
        let view = MoviesOfTheGenreView()

        let interactor = MoviesOfTheGenreInteractor(api: api, realm: realm)
        let presenter = MoviesOfTheGenrePresenter()
        let router = MoviesOfTheGenreRouter()

        vc.view = view
        interactor.presenter = presenter
        presenter.view = view
        view.interactor = interactor
        view.router = router
        router.viewController = vc

        interactor.getData(id: id, page: 1)
        interactor.setTitle(title: title)
        
        return vc
    }
}
