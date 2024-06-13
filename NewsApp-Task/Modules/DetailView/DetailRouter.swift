//
//  DetailRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class DetailRouter: DetailPresenterToRouterInterface {
    
    func showError(from: DetailViewController) {
        ErroHandleViewBuilder.showError(from: from)
    }

    func segueToWebView(newsUrl: String, view: DetailViewController) {
        let webVc = WebViewController(newsUrl: newsUrl)
        view.navigationController?.pushViewController(webVc, animated: true)
    }

}
