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
}

final class MainViewWorker: MainViewWorkingLogic {

    var networManager: NewsRepositoryInterface?
    var localDBManager: LocalDBManagerInterface?

    init(networManager: NewsRepositoryInterface? = nil, localDBManager: LocalDBManagerInterface? = LocalDBManager()) {
        self.networManager = networManager ?? NewsRepository()
        self.localDBManager = localDBManager
    }

    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        networManager?.getHeadLines(completion: completion)
    }

    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        networManager?.makeQuery(word: word, completion: completion)
    }

    func fetchFromDb(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        localDBManager?.fetchModel(completion: completion)
    }
}
