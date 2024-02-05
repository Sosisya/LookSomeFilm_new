//
//  CastAndCrewInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol CastAndCrewInteractorProtocol: AnyObject {
    func getData(id: Int?)
}

final class CastAndCrewInteractor: CastAndCrewInteractorProtocol {

    var presenter: CastAndCrewPresenterProtocol?
    private var api: NetworkManagerProtocol

    init(api: NetworkManagerProtocol) {
        self.api = api
    }

    func getData(id: Int?) {

        guard let id = id else { return }

        Task {
            do {
                let castAndCrew = try await api.getCastAndCrew(id: id)
                DispatchQueue.main.async {
                    self.presenter?.presentData(response: castAndCrew)
                }
            } catch {
                presenter?.presentError()
            }
        }
    }
}
