//
//  NetworkManager.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import Foundation

protocol NewNetworkManagerInterface {
    func request<T: Codable>(_ endpoint: Endpoint,completion: @escaping((Result<T,NewsAppErrors>)->()))
}

class NewNetworkManager: NewNetworkManagerInterface {
    
    static let shared = NewNetworkManager()
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint,completion: @escaping((Result<T,NewsAppErrors>)->())) {
        
        URLSession.shared.dataTask(with: endpoint.request()) { data,response,error in
            
            if error != nil {
                completion(.failure(.generalError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else  {
                completion(.failure(.generalError))
                return
            }
            
            guard let data = data  else {
                completion(.failure(.invalidRequest))
                return
            }

            self.handleResponse(data: data) { response in
                // present or interact data
                completion(response)
                
            }
        }.resume()
    }
    
    //MARK:  -Handle func
    
    fileprivate func handleResponse<T: Codable>(data: Data, compeltion: @escaping( (Result<T,NewsAppErrors>)-> () ) ) {
        
        do {
            let succesData =  try JSONDecoder().decode(T.self, from: data)
            compeltion(.success(succesData))
        } catch  {
            print(error)
            compeltion(.failure(.parsingError))
        }
        
    }
}

//MARK: - Requsts

extension NewNetworkManager {

    
    func getHeadLines(completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void) {
        let endPoint = Endpoint.topHeadlines
        request(endPoint, completion: completion)
    }
    
    func makeQuery(word: String,completion: @escaping (Result<NewsResponse, NewsAppErrors>) -> Void){
        let endpoint = Endpoint.query(query: word)
        request(endpoint, completion: completion)
    }
}


 
