//
//  HomePresenter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol HomePresenterProtocol {
    func presentData(popular: Popular?, upcoming: Upcoming?, topRated: TopRated?, nowPlaying: NowPlaying?)
    func presentError()
}

final class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var model: [HomeModel] = []

    func presentData(popular: Popular?, upcoming: Upcoming?, topRated: TopRated?, nowPlaying: NowPlaying?) {
        if let popularResult = popular?.results {
            model.append(HomeModel(section: .popular(popularResult), title: HomeSectionTitles.popularTitle)
            )
        }

        if let upcomingResult = upcoming?.results {
            model.append(HomeModel(section: .upcoming(upcomingResult), title: HomeSectionTitles.upcomingTitle)
            )
        }

        if let topRatedResult = topRated?.results {
            model.append(HomeModel(section: .topRated(topRatedResult), title: HomeSectionTitles.topRatedTitle)
            )
        }

        if let nowPlayingResult = nowPlaying?.results {
            model.append(HomeModel(section: .nowPlaying(nowPlayingResult), title: HomeSectionTitles.nowPlayingTitle)
            )
        }
        view?.displayData(viewModel: model)
    }

    func presentError() {
        view?.displayError()
    }
}
