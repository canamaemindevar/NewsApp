//
//  Protocols.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

protocol DetailViewToPresenterInterface {
    var interactor: DetailPresenterToInteractorInterface? { get set }
    var view: DetailPresenterToViewControllerInterface? { get set }
    var router: DetailPresenterToRouterInterface? { get set }
    func checkIsNewFav(article: Article?)
    func routeToWebView(newsUrl: String, view: DetailViewController)
}

protocol DetailPresenterToViewControllerInterface {
    func setNew(new: Article)
    func errorHandle()
}

protocol DetailPresenterToInteractorInterface {
    var presenter: DetailInteractorToViewPresenter? { get set }
    func setPage(new: Article?)
    func checkIsNewFav(article: Article?)
}

protocol DetailPresenterToRouterInterface {
   func segueToWebView(newsUrl: String, view: DetailViewController)
    func showError(from: DetailViewController) 
}

protocol DetailInteractorToViewPresenter {
    func handleResponse(new: Article?)
    func handleError()
}
