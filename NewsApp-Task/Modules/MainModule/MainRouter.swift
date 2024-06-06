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
        view.presenter?.mainInteractor = MainInteractor()
        view.presenter?.view = view
        view.presenter?.mainInteractor?.presenter = presenter
    }
    
    func routeToDetailView(new: Article) {
        
    }
}
