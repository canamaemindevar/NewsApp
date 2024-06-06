//
//  DetailInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class DetailInteractor: DetailPresenterToInteractorInterface {

    var presenter: DetailInteractorToViewPresenter?

    func setPage(new: Article?) {
        presenter?.handleResponse(new: new)
    }

    func checkIsNewFav(article: Article?) {
        guard let article else { return }
        LocalDBManager.shared.fetchModel (completion: { [weak self] response in
            switch response {
                case .success(let success):

                    guard let articles = success.articles else {return}

                    if ((self?.containsArticle(articles, article)) != nil) {

                        self?.deleteFromDB(model: article)

                    }else {
                        self?.saveToDB(model: article)
                    }

                case .failure(_):
                    self?.presenter?.handleError()
            }
        })
    }
}

private extension DetailInteractor {

    func saveToDB(model: Article) {
        LocalDBManager.shared.saveModel(with: model)
    }

    func deleteFromDB(model: Article) {
        LocalDBManager.shared.deleteModel(with: model)
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
