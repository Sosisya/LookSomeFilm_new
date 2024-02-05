//
//  MovieDetailsInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation

protocol MovieDetailsInteractorProtocol: AnyObject {
    func getData(id: Int?)
    func saveData(id: Int, movieDetails: MovieDetails)
    func deleteData(id: Int?)
}

final class MovieDetailsInteractor: MovieDetailsInteractorProtocol {

    var presenter: MovieDetailsPresenter?
    private var api: NetworkManagerProtocol
    private var realm: RealmManager

    init(api: NetworkManagerProtocol, realm: RealmManager) {
        self.api = api
        self.realm = realm
    }

    func getData(id: Int?) {
        guard let id = id else { return }

        Task {
            do {
                async let movieDetails = api.getMovieDetails(id: id)
                async let castAndCrew = api.getCastAndCrew(id: id)

                let (movieDetailsData, castAndCrewData) = try await (movieDetails, castAndCrew)

                DispatchQueue.main.async {
                    self.presenter?.presentData(movieDetails: movieDetailsData, castAndCrew: castAndCrewData)
                }
            } catch {
                presenter?.presentError()
            }
        }
    }

    #warning("JTBD: Обработать ошибки показывая соответствующие алерты в презентер и далее во вью")
    func saveData(id: Int, movieDetails: MovieDetails) {
        let realmObjects = realm.fetch()

        let modelExists = realmObjects.contains { $0.id == id }

        if !modelExists {
            do {
                let favouriteModel = FavouriteModel(
                    id: movieDetails.id,
                    posterPath: movieDetails.posterPath,
                    releaseDate: movieDetails.releaseDate,
                    title: movieDetails.title,
                    voteAverage: movieDetails.voteAverage
                )
                try realm.createUpdate(object: favouriteModel)
                NotificationCenter.default.post(name: NSNotification.Name("FavouriteObjectAddedNotification"), object: nil)
            } catch {
                presenter?.presentError()
            }
        } else {
            print("Объект уже существует")
        }
    }

    func deleteData(id: Int?) {
        do {
            let realmObjects = realm.fetch()

            let favouriteObject = realmObjects.filter { $0.id == id }

            guard let firstObject = favouriteObject.first else { return }
            try realm.delete(object: firstObject)
            NotificationCenter.default.post(name: NSNotification.Name("FavouriteObjectDeletedNotification"), object: nil)
        } catch {
            print("Ошибка удаления в Realm. MoviesOfTheGenre")
        }
    }
}
