//
//  MainRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.06.2024.
//

import Foundation


final class MainRouter: MainPresenterToRouterInterface {
    
    static func executeModule(view: MainViewController) {
        let presenter = MainPresenter()
        view.presenter = presenter
        view.presenter?.interactor = MainInteractor()
        view.presenter?.view = view
        view.presenter?.router = MainRouter()
        view.presenter?.interactor?.presenter = presenter
    }
    
    func routeToDetailView(new: Article, from view: MainViewController) {
        let vc = DetailViewController(article: new)
        let presenter = DetailPresenter()
        vc.presenter = presenter
        vc.presenter?.interactor = DetailInteractor()
        vc.presenter?.view = vc
        vc.presenter?.router = DetailRouter()
        vc.presenter?.interactor?.presenter = presenter
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
