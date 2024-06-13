//
//  NetworkHelpers.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import Foundation

protocol EndpointProtocol {
    var apiKey: String {get}
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case topHeadlines
    case query(query: String)
    
}


extension Endpoint: EndpointProtocol {
    var apiKey: String {
        return "b30173ead3f4471c8789b551cf4fb36a"
    }
    
    
    var baseURL: String {
        return "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .query: return "/v2/everything"
            
        case .topHeadlines: return "/v2/top-headlines"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .query: return .get
            
        case .topHeadlines: return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    //MARK: - Adding Params
    var parameters: [String : Any]? {
        return nil
    }
    
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }
        
        //MARK: -Add QueryItem
        
        if case .query(let query) = self {
            components.queryItems = [URLQueryItem(name: "q", value: query),
                                     URLQueryItem(name: "from", value: "2024-13-06"),
                                     URLQueryItem(name: "sortBy", value: "publishedAt"),
                                     URLQueryItem(name: "apiKey", value: apiKey)
            ]

        }
        
        if case .topHeadlines = self {
            components.queryItems = [URLQueryItem(name: "country", value: "tr"),
                                     URLQueryItem(name: "apiKey", value: apiKey)
            ]
           
        }
        
        //MARK: - Add Path
        components.path = path
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //MARK: - Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }
        
        
        //MARK: - Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}


 
