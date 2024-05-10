//
//  DetailViewModel.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.05.2024.
//

import Foundation

final class DetailViewModel: ViewModel {

    func makeFav(article: Article) {
        
        LocalDBManager.shared.fetchModel(completion: { response in
            switch response {
                case .success(let success):

                    guard let articless = success.articles else {return}
                    if self.containsArticle(articless, article) {

                        LocalDBManager.shared.deleteModel(with: article)

                    }else {
                        LocalDBManager.shared.saveModel(with: article)
                    }

                case .failure(_):
                    break
            }
        })
    }

    private func containsArticle(_ array: [Article], _ search: Article) -> Bool {
        for art in array {
            if art.title == search.title && art.url == search.url {
                return true
            }
        }
        return false
    }
}
