//
//  HomeInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func getData()
}

final class HomeInteractor: HomeInteractorProtocol {

    var presenter: HomePresenterProtocol?
    private var api: NetworkManagerProtocol

    init(api: NetworkManagerProtocol) {
        self.api = api
    }

    func getData() {
        Task {
            do {
                async let popular = api.getPopular()
                async let upcoming = api.getUpcoming()
                async let topRated = api.getTopRated()
                async let nowPlaying = api.getNowPlaying()

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
