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
        Spinner.start()
        worker.getHeadLines { [weak self] response in
            self?.handleNewsResponse(response: response)
            Spinner.stop()
        }
    }

    func makeQuery(word: String) {
        Spinner.start()
        worker.makeQuery(word: word) { [weak self] response in
            self?.handleNewsResponse(response: response)
            Spinner.stop()
        }
    }

    func fetchFromDb() {
        worker.fetchFromDb { [weak self] response in
            self?.handleNewsResponse(response: response)
        }
    }

    private func handleNewsResponse(response: Result<NewsResponse, NewsAppErrors>) {
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
