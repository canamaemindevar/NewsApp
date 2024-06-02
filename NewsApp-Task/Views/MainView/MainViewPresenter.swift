//
//  MainViewPresenter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

protocol MainViewPresentationLogic: AnyObject {
    func handleResponse(news: NewsResponse?)
    func handleError()
}

final class MainViewPresenter: MainViewPresentationLogic {
    
    weak var viewController: MainViewDisplayLogic?

    func handleResponse(news: NewsResponse?) {
        if let news {
            let displayableNews = MainViewModels.Case.ViewModel(news: news.articles)
            viewController?.updateView(news: displayableNews)
        } else {
            viewController?.handleError()
        }
    }

    func handleError() {
        viewController?.handleError()
    }

}
