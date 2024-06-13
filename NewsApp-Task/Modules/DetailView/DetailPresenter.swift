//
//  DetailPresenter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class DetailPresenter: DetailViewToPresenterInterface {
    var router: DetailPresenterToRouterInterface?
    var interactor: DetailPresenterToInteractorInterface?
    var view: DetailPresenterToViewControllerInterface?

    func setPage(new: Article?) {
        interactor?.setPage(new: new)
    }

    func checkIsNewFav(article: Article?) {
        interactor?.checkIsNewFav(article: article)
    }

    func routeToWebView(newsUrl: String, view: DetailViewController) {
        router?.segueToWebView(newsUrl: newsUrl, view: view)
    }
}

extension DetailPresenter: DetailInteractorToViewPresenter {
    func handleError() {
        view?.errorHandle()
    }
    
    func handleResponse(new: Article?) {
        let newArticle = Article(source: new?.source,
                                 author: new?.author,
                                 title: new?.title,
                                 description: new?.description ?? "Details are coming soon",
                                 url: new?.url,
                                 urlToImage: new?.urlToImage,
                                 publishedAt: formatDate(date: new?.publishedAt),
                                 content: new?.content)

        view?.setNew(new: newArticle)
    }


}
private extension DetailPresenter {

    func formatDate(date: String?) -> String? {
        guard let dateString = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "tr_TR")

        guard let inputDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "tr_TR")
        outputFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
        return outputFormatter.string(from: inputDate)
    }
}
