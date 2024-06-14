//
//  DetailInteractor.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class DetailInteractor: DetailPresenterToInteractorInterface {

    var presenter: DetailInteractorToViewPresenter?
    var localDBManager: LocalDBManagerInterface?

    init( localDBManager: LocalDBManagerInterface? = LocalDBManager()) {
        self.localDBManager = localDBManager
    }

    func setPage(new: Article?) {
        presenter?.handleResponse(new: new)
    }

    func checkIsNewFav(article: Article?) {
        guard let article else { return }
        localDBManager?.fetchModel (completion: { [weak self] response in
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
        localDBManager?.saveModel(with: model)
    }

    func deleteFromDB(model: Article) {
        localDBManager?.deleteModel(with: model)
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
