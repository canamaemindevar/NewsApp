//
//  MainCoordinator.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 26.05.2024.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabbarController = TabbarCoordinator(navigationController: navigationController)
        childCoordinators.append(tabbarController)
        tabbarController.mainCoordinator = self
        tabbarController.start()
    }
}
