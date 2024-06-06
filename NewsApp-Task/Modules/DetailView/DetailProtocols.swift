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
    func checkIsNewFav(article: Article?)
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
    static func executeModule(view: DetailViewController)
}

protocol DetailInteractorToViewPresenter {
    func handleResponse(new: Article?)
    func handleError()
}
