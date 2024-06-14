//
//  MainInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class MainInteractor: MainPresenterToInteractorInterface {
    
    var presenter: MainInteractorToViewPresenter?

    var networkManager: NewsRepositoryInterface?
    var localDBManager: LocalDBManagerInterface?

    init(networkManager: NewsRepositoryInterface? = nil, localDBManager: LocalDBManagerInterface? = LocalDBManager()) {
        self.networkManager = networkManager ?? NewsRepository()
        self.localDBManager = localDBManager
    }

    func getHeadLines() {
        Spinner.start()
        networkManager?.getHeadLines(completion: handleNewsResponse(response:))
    }

    func makeQuery(word: String) {
        Spinner.start()
        networkManager?.makeQuery(word: word, completion: handleNewsResponse(response:))
    }

    func fetchFromDb() {
        Spinner.start()
        localDBManager?.fetchModel(completion: handleNewsResponse(response:))
    }

    func handleNewsResponse(response: Result<NewsResponse, NewsAppErrors>) {

        switch response {
            case .success(let success):
                print(success)
                self.presenter?.handleResponse(news: success)
            case .failure(_):
                self.presenter?.handleError()
        }
           Spinner.stop()
    }
}
