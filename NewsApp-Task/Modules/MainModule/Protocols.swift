//
//  Protocols.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

protocol MainViewToPresenterInterface {
    var mainInteractor: MainPresenterToMainInteractorInterface? { get set }
    var view: MainPresenterToMainViewControllerInterface? { get set }
    func getHeadLines()
    func makeQuery(word: String)
    func fetchFromDb()

}
protocol MainPresenterToMainViewControllerInterface {

    func updateView(news: NewsResponse?)
    func handleError()
}

protocol MainPresenterToMainInteractorInterface {
    var presenter: MainInteractorToMainViewPresenter? { get set }
    // query
    func getHeadLines()
    func makeQuery(word: String)
    func fetchFromDb()

}

protocol MainPresenterToMainRouterInterface {
    static func executeModule(view: MainViewController)
}
protocol MainInteractorToMainViewPresenter {
    func handleResponse(news: NewsResponse?)
    func handleError()
}

