//
//  HomeInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func getData(page: Int?)
}

final class HomeInteractor: HomeInteractorProtocol {

    var presenter: HomePresenterProtocol?
    private var api: NetworkManagerProtocol

    init(api: NetworkManagerProtocol) {
        self.api = api
    }

    func getData(page: Int?) {
        guard let page = page else { return }

        Task {
            do {
                async let popular = api.getPopular(page: page)
                async let upcoming = api.getUpcoming(page: page)
                async let topRated = api.getTopRated(page: page)
                async let nowPlaying = api.getNowPlaying(page: page)

                let (popularData, upcomingData, topRatedData, nowPlayingData) = try await (popular, upcoming, topRated, nowPlaying)

                DispatchQueue.main.async {
                    self.presenter?.presentData(popular: popularData, upcoming: upcomingData, topRated: topRatedData, nowPlaying: nowPlayingData)
                }
            } catch {
                presenter?.presentError()
            }
        }
    }
}
