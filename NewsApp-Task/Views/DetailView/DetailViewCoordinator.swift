//
//  DetailViewCoordinator.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 26.05.2024.
//

import UIKit

final class DetailPageCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var article: Article

    init(navigationController: UINavigationController, article: Article) {
        self.navigationController = navigationController
        self.article = article
    }

    func start() {
        let detailVc = DetailViewController(article: article)
        detailVc.viewModel = DetailViewModel()
        detailVc.coordinator = self
        navigationController.pushViewController(detailVc, animated: true)
    }

    func goToWebView(newsUrl: String ) {
        let webVc = WebViewController(newsUrl: newsUrl)
        navigationController.pushViewController(webVc, animated: true)
    }
}
