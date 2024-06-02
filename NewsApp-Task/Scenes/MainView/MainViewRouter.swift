//
//  MainViewRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

protocol MainViewRoutingLogic: AnyObject {
    func goToDetailView(article: Article)
}

protocol MainViewDataPassing: class {
    var dataStore: MainViewDataStore? { get }
}

final class MainViewRouter: MainViewRoutingLogic, MainViewDataPassing {
    
    weak var viewController: MainViewController?
    var dataStore: MainViewDataStore?
    

    func goToDetailView(article: Article) {
        let detailVc = DetailViewController(article: article)
        self.viewController?.navigationController?.pushViewController(detailVc, animated: true)
    }
}
