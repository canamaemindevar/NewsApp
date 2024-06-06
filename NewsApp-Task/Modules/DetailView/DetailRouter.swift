//
//  DetailRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation

final class DetailRouter {
    static func executeModule(view: DetailViewController) {
        let presenter = DetailPresenter()
        view.presenter = presenter
        view.presenter?.interactor = DetailInteractor()
        view.presenter?.view = view
        view.presenter?.interactor?.presenter = presenter
    }
}
