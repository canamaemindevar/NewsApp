//
//  NewsRepositoryInterface.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 14.06.2024.
//

import Foundation

protocol NewsRepositoryInterface {
    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void)
}
