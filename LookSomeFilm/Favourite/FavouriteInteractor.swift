//
//  FavouriteInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 24.01.2024.
//

import Foundation

protocol FavouriteInteractorProtocol: AnyObject {
    func fetchData()
    func removeData(object: FavouriteModel)
}

final class FavouriteInteractor: FavouriteInteractorProtocol {

    var presenter: FavouritePresenterProtocol?

    private var manager: RealmManager

    init(manager: RealmManager) {
        self.manager = manager
    }

    func fetchData() {
        let data = manager.fetch()
        presenter?.presentData(data: data)
    }

    func removeData(object: FavouriteModel) {
        try? manager.delete(object: object)
        let data = manager.fetch()
        presenter?.presentData(data: data)
    }
}
