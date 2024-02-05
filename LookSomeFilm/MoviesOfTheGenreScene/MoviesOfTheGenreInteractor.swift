//
//  MoviesOfTheGenreInteractor.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import Foundation
import Realm

protocol MoviesOfTheGenreInteractorProtocol: AnyObject {
    func getData(id: Int?, page: Int?)
    func saveData(model: Result)
    func deleteData(id: Int?)
    func setTitle(title: String?)
}

final class MoviesOfTheGenreInteractor: MoviesOfTheGenreInteractorProtocol {
   
    var presenter: MoviesOfTheGenrePresenterProtocol?

    private var api: NetworkManager
    private var realm: RealmManager

    init(api: NetworkManager, realm: RealmManager) {
        self.api = api
        self.realm = realm
    }

    
    func getData(id: Int?, page: Int?) {
        guard let page = page else { return }

        Task {
            do {
                guard let id = id else { return }
                let moviesOfTheGenre = try await api.getMoviesOfTheGenre(id: id, page: page)
                
                DispatchQueue.main.async {
                    self.presenter?.presentData(id: id, response: moviesOfTheGenre)
                }
            } catch {
                presenter?.presentError()
            }
        }
    }

    
    func saveData(model: Result) {
        let realmObjects = realm.fetch()
        let modelExists = realmObjects.contains { $0.id == model.id }

        if !modelExists {
            do {
                let favouriteModel = FavouriteModel(
                    id: model.id,
                    posterPath: model.posterPath,
                    releaseDate: model.releaseDate,
                    title: model.title,
                    voteAverage: model.voteAverage
                )
                try realm.createUpdate(object: favouriteModel)
                NotificationCenter.default.post(name: NSNotification.Name("FavouriteObjectAddedNotification"), object: nil)
            } catch {
                presenter?.presentError()
            }
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
            presenter?.presentError()
        }
    }

    
    func setTitle(title: String?) {
        guard let title = title else { return }
        presenter?.presentTitle(title: title)
    }
}

