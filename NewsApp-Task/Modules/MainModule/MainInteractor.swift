//
//  MainInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class MainInteractor: MainPresenterToInteractorInterface {
    
    var presenter: MainInteractorToViewPresenter?

    func getHeadLines() {
        NewNetworkManager.shared.getHeadLines(completion: handleNewsResponse(response:))
    }

    func makeQuery(word: String) {
        NewNetworkManager.shared.makeQuery(word: word, completion: handleNewsResponse(response:))
    }

    func fetchFromDb() {
        LocalDBManager.shared.fetchModel(completion: handleNewsResponse(response:))
    }

    func handleNewsResponse(response: Result<NewsResponse, NewsAppErrors>) {
        //  Spinner.start()
        switch response {
            case .success(let success):
                print(success)
                self.presenter?.handleResponse(news: success)
            case .failure(_):
                self.presenter?.handleError()
        }
        //   Spinner.stop()
    }
}
