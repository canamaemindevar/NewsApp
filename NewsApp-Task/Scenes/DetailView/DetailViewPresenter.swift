//
//  DetailViewPresenter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 2.06.2024.
//

import Foundation

protocol DetailViewPresentationLogic: AnyObject {
    func handleResponse(new: Article?)
    func handleError()
}

final class DetailViewPresenter: DetailViewPresentationLogic {

    weak var viewController: DetailViewDisplayLogic?

    func handleResponse(new: Article?) {
        let newArticle = Article(source: new?.source,
                                 author: new?.author,
                                 title: new?.title,
                                 description: new?.description ?? "Details are coming soon",
                                 url: new?.url,
                                 urlToImage: new?.urlToImage,
                                 publishedAt: formatDate(date: new?.publishedAt),
                                 content: new?.content)
        
        viewController?.setNew(article: newArticle)
    }

    func handleError() {
        viewController?.errorHandle()
    }
}

private extension DetailViewPresenter {

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
