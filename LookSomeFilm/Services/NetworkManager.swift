//
//  NetworkManager.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.11.2023.
//

import UIKit
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func getPopular() async throws -> Popular?
    func getNowPlaying() async throws -> NowPlaying?
    func getUpcoming() async throws -> Upcoming?
    func getTopRated() async throws -> TopRated?
    func getGenres() async throws -> Genres?
    func getMoviesOfTheGenre(id: Int, page: Int) async throws -> MoviesOfGenre?
    func getMovieDetails(id: Int) async throws -> MovieDetails?
    func getCastAndCrew(id: Int) async throws -> CastAndCrew?
}

final class NetworkManager: NetworkManagerProtocol {

    // MARK: - Variable
    private let baseURL = URL(string: URLs.baseURL)
    private let apiKey = APIKey.key
    
    private var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return Session(configuration: configuration)
    }()
    
    
    // MARK: - Network layer
    private func fetchData<T: Decodable>(request: String) async throws -> T? {
        guard let url = baseURL else { return nil }
        let endpoint: URL?
        let apiKey = URLQueryItem(name: "api_key", value: APIKey.key)
        endpoint = url
            .appendingPathComponent(request)
            .appending(queryItems: [apiKey])
        
        return try await withCheckedThrowingContinuation { continuation in
            guard let endpoint = endpoint else { return }

            session.request(endpoint.absoluteString, method: .get).validate().responseDecodable(of: T.self) { response in
                if let result = response.value {
                    continuation.resume(returning: result)
                }
                
                if let error = response.error {
                    debugPrint(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private func fetchGenresData<T: Decodable>(request: String, forGenreId: String, forPage: String) async throws -> T? {
        guard let url = baseURL else { return nil }
        var endpoint: URL?
        let apiKey = URLQueryItem(name: "api_key", value: APIKey.key)
        let genreItems = URLQueryItem(name: "with_genres", value: forGenreId)
        let pageId = URLQueryItem(name: "page", value: forPage)
        endpoint = url
            .appendingPathComponent(request)
            .appending(queryItems: [apiKey, genreItems, pageId])

        return try await withCheckedThrowingContinuation { continuation in
            guard let endpoint = endpoint else { return }

            session.request(endpoint.absoluteString, method: .get).validate().responseDecodable(of: T.self) { response in
                if let result = response.value {
                    continuation.resume(returning: result)
                }

                if let error = response.error {
                    debugPrint(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    
    // MARK: - Protocol Implemetation
    func getPopular() async throws -> Popular? {
        let request = Requests.popular
        let data: Popular? = try await fetchData(request: request)
        return data
    }

    func getNowPlaying() async throws -> NowPlaying? {
        let request = Requests.nowPlaying
        let data: NowPlaying? = try await fetchData(request: request)
        return data
    }

    func getUpcoming() async throws -> Upcoming? {
        let request = Requests.upcoming
        let data: Upcoming? = try await fetchData(request: request)
        return data
    }

    func getTopRated() async throws -> TopRated? {
        let request = Requests.topRated
        let data: TopRated? = try await fetchData(request: request)
        return data
    }

    func getGenres() async throws -> Genres? {
        let request = Requests.genres
        let data: Genres? = try await fetchData(request: request)
        return data
    }

    func getMoviesOfTheGenre(id: Int, page: Int) async throws -> MoviesOfGenre? {
        let forGenreId = "\(id)"
        let pageId = "\(page)"
        let request = Requests.moviesOfTheGenre
        let data: MoviesOfGenre? = try await fetchGenresData(request: request, forGenreId: forGenreId, forPage: pageId)
        return data
    }

    func getMovieDetails(id: Int) async throws -> MovieDetails? {
        let movieId = "\(id)"
        let request = Requests.movieDetails + movieId
        let data: MovieDetails? = try await fetchData(request: request)
        return data
    }

    func getCastAndCrew(id: Int) async throws -> CastAndCrew? {
        let movieId = "\(id)/credits"
        let request = Requests.castAndCrew + movieId
        let data: CastAndCrew? = try await fetchData(request: request)
        return data
    }
}
