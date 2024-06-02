//
//  DetailViewInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 2.06.2024.
//

import Foundation

protocol DetailViewBusinessLogic: AnyObject {
    func setPage()
    func checkIsNewFav()
}

protocol DetailViewDataStore: AnyObject {
    var article: Article? { get set }
}

final class DetailViewInteractor: DetailViewBusinessLogic, DetailViewDataStore {
    
    var presenter: DetailViewPresentationLogic?
    var worker: DetailViewWorkingLogic = DetailViewWorker()
    
    var article: Article?

    func setPage() {
        presenter?.handleResponse(new: article)
    }


    func checkIsNewFav() {
        guard let article else { return }
        worker.fetchFromDb(completion: { [weak self] response in
            switch response {
                case .success(let success):

                    guard let articles = success.articles else {return}

                    if ((self?.containsArticle(articles, article)) != nil) {

                        self?.worker.deleteFromDB(model: article)

                    }else {
                        self?.worker.saveToDB(model: article)
                    }

                case .failure(_):
                    self?.presenter?.handleError()
            }
        })
    }
}

private extension DetailViewInteractor {

    func saveToDB(model: Article) {
        worker.saveToDB(model: model)
    }

    func deleteFromDB(model: Article) {
        worker.deleteFromDB(model: model)
    }

    func containsArticle(_ array: [Article], _ search: Article) -> Bool {
        for art in array {
            if art.title == search.title && art.url == search.url {
                return true
            }
        }
        return false
    }
}
