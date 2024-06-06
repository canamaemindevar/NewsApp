//
//  MainPresenter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation


final class MainPresenter: MainViewToPresenterInterface {

    var mainInteractor: MainPresenterToMainInteractorInterface?
    var view: MainPresenterToMainViewControllerInterface?

    func getHeadLines() {
        mainInteractor?.getHeadLines()
    }

    func makeQuery(word: String) {
        mainInteractor?.getHeadLines()
    }

    func fetchFromDb() {
        mainInteractor?.fetchFromDb()
    }
}

extension MainPresenter: MainInteractorToMainViewPresenter {
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
