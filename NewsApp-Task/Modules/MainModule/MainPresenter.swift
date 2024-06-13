//
//  MainPresenter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation


final class MainPresenter: MainViewToPresenterInterface {

    var interactor: MainPresenterToInteractorInterface?
    var view: MainPresenterToViewControllerInterface?
    var router: MainPresenterToRouterInterface?

    func getHeadLines() {
        interactor?.getHeadLines()
    }

    func makeQuery(word: String) {
        interactor?.getHeadLines()
    }

    func fetchFromDb() {
        interactor?.fetchFromDb()
    }
    func goToDetail(new: Article, view: MainViewController) {
        router?.routeToDetailView(new: new, from: view)
    }
}

extension MainPresenter: MainInteractorToViewPresenter {
    func handleResponse(news: NewsResponse?) {
        if let news {
            view?.updateView(news: news)
        } else {
            view?.handleError()
        }

    }
    
    func handleError() {
        view?.handleError()
    }
    

}
