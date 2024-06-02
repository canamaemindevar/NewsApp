//
//  MainViewModels.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import Foundation

// swiftlint:disable nesting

typealias Article = MainViewModels.Case.Article
typealias NewsResponse = MainViewModels.Case.NewsResponse
typealias NewsAppErrors = MainViewModels.NewsAppErrors

enum MainViewModels {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response: Decodable {
            let newsResponse: NewsResponse?
        }
        
        struct ViewModel {
            let news: [Article]?
        }
        struct NewsResponse: Codable {
            let status: String?
            let totalResults: Int?
            let articles: [Article]?
        }

        // MARK: - Article
        struct Article: Codable {
            let source: Source?
            let author, title: String?
            let description: String?
            let url: String?
            let urlToImage: String?
            let publishedAt: String?
            let content: String?
        }

        // MARK: - Source
        struct Source: Codable {
            let id: String?
            let name: String?
        }
    }

    enum DataSourceForMainView: String {

        case SearchPage
        case FavoritePage

        func setTitle() -> String {
            switch self {
                case .SearchPage:
                    return "News"
                case .FavoritePage:
                    return "Favorites"
            }
        }
    }

    enum NewsAppErrors: String, Error {

        case invalidUrl = "InvalidUrl"
        case noData = "No data"
        case invalidRequest = "Invalid request"
        case generalError = "General Error"
        case parsingError = "Parsing Error"
        case localDBError = "Local DB fetching error"
    }

}
// swiftlint:enable nesting
