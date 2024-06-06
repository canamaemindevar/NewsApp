//
//  Protocols.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

protocol MainViewToPresenterInterface {
    var mainInteractor: MainPresenterToInteractorInterface? { get set }
    var view: MainPresenterToViewControllerInterface? { get set }
    func getHeadLines()
    func makeQuery(word: String)
    func fetchFromDb()
}

protocol MainPresenterToViewControllerInterface {
    func updateView(news: NewsResponse?)
    func handleError()
}

protocol MainPresenterToInteractorInterface {
    var presenter: MainInteractorToViewPresenter? { get set }
    func getHeadLines()
    func makeQuery(word: String)
    func fetchFromDb()
}

protocol MainPresenterToRouterInterface {
    static func executeModule(view: MainViewController)
    func routeToDetailView(new: Article)
}

protocol MainInteractorToViewPresenter {
    func handleResponse(news: NewsResponse?)
    func handleError()
}

