//
//  Constants.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.11.2023.
//

import Foundation

enum APIKey {
    static let key = "c7ead67bdd4b4fbb6b19fee66be8c9dd"
}

enum URLs {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/original"
}

enum Requests {
    static let popular = "movie/popular"
    static let nowPlaying = "movie/now_playing"
    static let upcoming = "movie/upcoming"
    static let topRated = "movie/top_rated"
    static let movieDetails = "movie/"
    static let castAndCrew = "movie/"
    static let genres = "genre/movie/list"
    static let moviesOfTheGenre = "discover/movie" 
}

enum CastAndCrewTitles {
    static let headerTitle = "Cast and crew"
    static let headerButtonTitle = "All participant"
    static let defaultImageName = "defaultPerson"
}

enum EmptyViewTitle {
    static let title = "It seems that your favorites is empty. \n\n Pick most-liked movies up to create your list."
}


enum NavigationTitles {
    static let genres = "Genres"
    static let favourites = "Favourites"
}

enum HomeSectionTitles {
    static let popularTitle = "Popular"
    static let topRatedTitle = "Top rated"
    static let upcomingTitle = "Upcoming"
    static let nowPlayingTitle = "Now playing"
}

enum NotificationTitles {
    static let added = "FavouriteObjectAddedNotification"
    static let deleted = "FavouriteObjectDeletedNotification"
}
