//
//  FavouriteBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import UIKit

final class FavouriteBuilder {
    static func build() -> UIViewController {

        let realm = RealmManager()

        let vc = FavouriteViewController()
        let view = FavouriteView()
        let interactor = FavouriteInteractor(manager: realm)
        let presenter = FavouritePresenter()
        let router = FavouriteRouter()

        vc.view = view
        interactor.presenter = presenter
        presenter.view = view
        view.interactor = interactor
        view.router = router
        router.viewController = vc

        interactor.fetchData()

        return vc
    }
}
