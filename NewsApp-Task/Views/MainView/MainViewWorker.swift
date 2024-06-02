//
//  MainViewWorker.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

protocol MainViewWorkingLogic: AnyObject {
    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
    func fetchFromDb(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
    func saveToDB(model: Article)
    func deleteFromDB(model: Article)
}

final class MainViewWorker: MainViewWorkingLogic {

    var networManager = NewNetworkManager.shared
    var localDBManager = LocalDBManager.shared

    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        let endPoint = Endpoint.topHeadlines
        networManager.request(endPoint, completion: completion)
    }

    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        let endpoint = Endpoint.query(query: word)
        networManager.request(endpoint, completion: completion)
    }

    func fetchFromDb(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        localDBManager.fetchModel(completion: completion)
    }

    // kaldir detaile koy
    func saveToDB(model: Article) {
        localDBManager.saveModel(with: model)
    }

    func deleteFromDB(model: Article) {
        localDBManager.deleteModel(with: model)
    }
}
