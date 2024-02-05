//
//  GenresInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.01.2024.
//

import Foundation

protocol GenresInteractorProtocol: AnyObject {
    func getGenres()
}

final class GenresInteractor: GenresInteractorProtocol {
    var presenter: GenresPresenterProtocol?
    private var api: NetworkManagerProtocol

    init(api: NetworkManagerProtocol) {
        self.api = api
    }

    func getGenres() {
        Task {
            do {
                let genres = try await api.getGenres()
                DispatchQueue.main.async {
                    self.presenter?.presentGenres(response: genres)
                }
            } catch {
                presenter?.presentError()
            }
        }
    }
}
