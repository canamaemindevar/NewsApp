//
//  MainViewRouter.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

protocol MainViewRoutingLogic: AnyObject {
    
}

protocol MainViewDataPassing: class {
    var dataStore: MainViewDataStore? { get }
}

final class MainViewRouter: MainViewRoutingLogic, MainViewDataPassing {
    
    weak var viewController: MainViewController?
    var dataStore: MainViewDataStore?
    
}
