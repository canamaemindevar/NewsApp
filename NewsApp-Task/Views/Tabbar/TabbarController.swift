//
//  TabbarController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.07.2023.
//

import UIKit

final class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newsVC = MainViewController()
        newsVC.router?.dataStore?.pageChoice = .SearchPage
        let favVC = MainViewController()
        favVC.router?.dataStore?.pageChoice = .FavoritePage
        let newsNc = UINavigationController(rootViewController: newsVC)
        let favNC = UINavigationController(rootViewController: favVC)
        
        newsNc.tabBarItem.image = UIImage(systemName: "house")
        newsNc.title = "News"
        favNC.tabBarItem.image = UIImage(systemName: "heart.fill")
        favNC.title = "Favorites"

        setViewControllers([newsNc,favNC], animated: true)
    }
}
