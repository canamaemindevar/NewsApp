//
//  TabbarController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.07.2023.
//

import UIKit

final class TabbarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var mainCoordinator: MainCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, mainCoordinator: MainCoordinator? = nil) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let tabbar = UITabBarController()

        let newsNavigationController = UINavigationController()
        let mainPageCoordinator = MainPageCoordinator(navigationController: newsNavigationController, pageChoice: .SearchPage)
        childCoordinators.append(mainPageCoordinator)
        mainPageCoordinator.start()

        let favsNavigationController = UINavigationController()
        let favPageCoordinator = MainPageCoordinator(navigationController: favsNavigationController, pageChoice: .FavoritePage)
        childCoordinators.append(favPageCoordinator)
        favPageCoordinator.start()

        newsNavigationController.tabBarItem.image = UIImage(systemName: "house")
        newsNavigationController.title = "News"
        favsNavigationController.tabBarItem.image = UIImage(systemName: "heart.fill")
        favsNavigationController.title = "Favorites"

        tabbar.setViewControllers([newsNavigationController, favsNavigationController], animated: true)
        navigationController.setViewControllers([tabbar], animated: true)
    }
}
