//
//  MovieDetailsBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

final class MovieDetailsBuilder {
    static func build(id: Int?) -> UIViewController {
        let api = NetworkManager()
        let realm = RealmManager()

        let vc = MovieDetailsViewController()
        let view = MovieDetailsView()
        let interactor = MovieDetailsInteractor(api: api, realm: realm)
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()

        vc.view = view
        interactor.presenter = presenter
        presenter.view = view
        view.interactor = interactor
        view.router = router
        router.viewController = vc

        interactor.getData(id: id)

        return vc
    }
}
