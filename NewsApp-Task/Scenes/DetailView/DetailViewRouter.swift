//
//  DetailViewRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 2.06.2024.
//

import Foundation

protocol DetailViewRoutingLogic: AnyObject {
    func showErrorView()
    func goToWebView()
}

protocol DetailViewDataPassing: class {
    var dataStore: DetailViewDataStore? { get }
}

final class DetailViewRouter: DetailViewRoutingLogic, DetailViewDataPassing {
    
    weak var viewController: DetailViewController?
    var dataStore: DetailViewDataStore?

    func showErrorView() {
        ErroHandleViewBuilder.showError(from: self.viewController)
    }

    func goToWebView() {
        guard let newsUrl = dataStore?.article?.url else {return}
        let webVc = WebViewController(newsUrl: newsUrl)
        self.viewController?.navigationController?.pushViewController(webVc, animated: true)
    }

}
