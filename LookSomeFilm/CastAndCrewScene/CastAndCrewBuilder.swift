//
//  CastAndCrewBuilder.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

final class CastAndCrewBuilder {
    static func build(id: Int?) -> UIViewController {
        let api = NetworkManager()

        let vc = CastAndCrewController()
        let view = CastAndCrewView()
        let interactor = CastAndCrewInteractor(api: api)
        let presenter = CastAndCrewPresenter()
        let router = CastAndCrewRouter()

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
