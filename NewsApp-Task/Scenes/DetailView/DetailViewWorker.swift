//
//  DetailViewWorker.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 2.06.2024.
//

import Foundation

protocol DetailViewWorkingLogic: AnyObject {
    func saveToDB(model: Article)
    func deleteFromDB(model: Article)
    func fetchFromDb(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
}

final class DetailViewWorker: DetailViewWorkingLogic {
    
    var localDBManager = LocalDBManager.shared

    func saveToDB(model: Article) {
        localDBManager.saveModel(with: model)
    }

    func deleteFromDB(model: Article) {
        localDBManager.deleteModel(with: model)
    }

    func fetchFromDb(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        localDBManager.fetchModel(completion: completion)
    }
}
