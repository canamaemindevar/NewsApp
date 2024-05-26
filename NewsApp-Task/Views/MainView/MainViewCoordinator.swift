//
//  MainViewCoordinator.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 26.05.2024.
//

import UIKit

final class MainPageCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var pageChoice: DataSourceForMainView
    
    init(navigationController: UINavigationController, pageChoice: DataSourceForMainView) {
        self.navigationController = navigationController
        self.pageChoice = pageChoice
    }

    func start() {
        let newsVC = MainViewController(pageChoice: pageChoice)
        let newsVm = MainViewModel()
        newsVC.viewModel = newsVm
        newsVC.coordinator = self
        navigationController.setViewControllers([newsVC], animated: false)
    }

    func goToDetailPage(article: Article) {

        let detailPageCoordinator = DetailPageCoordinator(navigationController: navigationController, article: article)
        childCoordinators.append(detailPageCoordinator)
        detailPageCoordinator.start()
    }
}
