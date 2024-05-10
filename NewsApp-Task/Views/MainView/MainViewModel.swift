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


    func getFavsFromDb() {
        LocalDBManager.shared.fetchModel { response in
            switch response {
                case .success(let success):
                    self.succesCompletion?(success)
                case .failure(_):
                    self.failCompleetion?()
            }
        }
    }

    func getHeadlines() {
        Spinner.start()
        NewNetworkManager.shared.getHeadLines { response in
            switch response {
                case .success(let success):
                    self.succesCompletion?(success)
                case .failure(_):
                    self.failCompleetion?()
            }
            Spinner.stop()
        }
    }

    func makeQuery(text: String) {
        NewNetworkManager.shared.makeQuery(word: text) { response in
            switch response {
                case .success(let success):
                    self.succesCompletion?(success)
                case .failure(_):
                    self.failCompleetion?()
            }
        }
    }
}
