//
//  MainViewModel.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation

final class MainViewModel: ViewModel{

    var succesCompletion: ((NewsResponse) -> Void)?
    var failCompleetion: (() -> Void)?

    var networkManager: NewsRepositoryInterface?
    var localDBManager: LocalDBManagerInterface?

    init(networkManager: NewsRepositoryInterface? = nil,
         localDBManager: LocalDBManagerInterface? = LocalDBManager()) {
        self.networkManager = networkManager ?? NewsRepository()
        self.localDBManager = localDBManager
    }

    func getFavsFromDb() {
        localDBManager?.fetchModel {[ weak self] response in
            self?.handleNewsResponse(response: response)
        }
    }

    func getHeadlines() {
        Spinner.start()
        networkManager?.getHeadLines { [ weak self] response in
            self?.handleNewsResponse(response: response)
            Spinner.stop()
        }
    }

    func makeQuery(text: String) {
        Spinner.start()
        networkManager?.makeQuery(word: text, completion: {[ weak self] response in
            self?.handleNewsResponse(response: response)
            Spinner.stop()
        })
    }

    private func handleNewsResponse(response: Result<NewsResponse, NewsAppErrors>) {
        switch response {
            case .success(let success):
                self.succesCompletion?(success)
            case .failure(_):
                self.failCompleetion?()
        }
    }
}
