//
//  MainViewInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

protocol MainViewBusinessLogic: AnyObject {
    func getHeadLines()
    func makeQuery(word: String)
    func fetchFromDb()
    func saveToDB(model: Article)
    func deleteFromDB(model: Article)
}

protocol MainViewDataStore: AnyObject {
    var pageChoice: MainViewModels.DataSourceForMainView? { get set }
    var newsArray: NewsResponse? { get }
}

final class MainViewInteractor: MainViewBusinessLogic, MainViewDataStore {
    
    var presenter: MainViewPresentationLogic?
    var worker: MainViewWorkingLogic = MainViewWorker()
    
    var pageChoice: MainViewModels.DataSourceForMainView?

    var newsArray: NewsResponse?

    func getHeadLines() {
        worker.getHeadLines { response in
            switch response {
                case .success(let success):
                    self.newsArray = success
                    self.presenter?.handleResponse(news: self.newsArray)
                case .failure(let failure):
                    self.presenter?.handleError()
                    print(failure)
            }
        }
    }

    func makeQuery(word: String) {
        worker.makeQuery(word: word) { response in
            switch response {
                case .success(let success):
                    self.newsArray = success
                    self.presenter?.handleResponse(news: self.newsArray)
                case .failure(let failure):
                    self.presenter?.handleError()
                    print(failure)
            }
        }
    }

    func fetchFromDb() {
        worker.fetchFromDb { response in
            switch response {
                case .success(let success):
                    self.newsArray = success
                    self.presenter?.handleResponse(news: self.newsArray)
                case .failure(let failure):
                    self.presenter?.handleError()
                    print(failure)
            }
        }
    }

    func saveToDB(model: Article) {
        worker.saveToDB(model: model)
    }

    func deleteFromDB(model: Article) {
        worker.deleteFromDB(model: model)
    }

}
