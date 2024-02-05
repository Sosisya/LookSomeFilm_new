//
//  SceneDelegate.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.11.2023.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var homeVC = HomeBuilder.build()
    private lazy var genresVC = GenresBuilder.build()
    private lazy var favouriteVC = FavouriteBuilder.build()

    private lazy var tabController: UITabBarController = {
        let tbc = UITabBarController()
        tbc.tabBar.unselectedItemTintColor = .customDarkGray
        tbc.tabBar.tintColor = .customOrange
        tbc.tabBar.backgroundColor = .customLightGray
        return tbc
    }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }

    
    private func createTabBarController() -> UITabBarController {
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        genresVC.tabBarItem = UITabBarItem(title: "Genres", image: UIImage(systemName: "book"), tag: 1)
        favouriteVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "bookmark"), tag: 2)

        tabController.viewControllers = [homeVC, genresVC, favouriteVC]

        return tabController
    }
}
