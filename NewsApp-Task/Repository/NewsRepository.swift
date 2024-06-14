//
//  NewsRepository.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 14.06.2024.
//

import Foundation

final class NewsRepository: NewsRepositoryInterface {

    var networkManager: CoreNetworkManagerInterface = CoreNetworkManager()

    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        let endPoint = Endpoint.topHeadlines
        networkManager.request(endPoint, completion: completion)
    }

    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void){
        let endpoint = Endpoint.query(query: word)
        networkManager.request(endpoint, completion: completion)
    }
}
