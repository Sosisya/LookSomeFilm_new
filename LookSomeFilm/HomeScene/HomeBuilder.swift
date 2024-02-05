//
//  HomeBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

final class HomeBuilder {

    static func build() -> UIViewController {

        let api = NetworkManager()

        let vc = HomeViewController()
        let view = HomeView()
        let interactor = HomeInteractor(api: api)
        let presenter = HomePresenter()
        let router = HomeRouter()

        vc.view = view
        interactor.presenter = presenter
        presenter.view = view
        view.interactor = interactor
        view.router = router
        router.viewController = vc
        
        interactor.getData()
        
        return vc
    }
}
