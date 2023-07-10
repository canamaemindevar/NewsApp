//
//  LocalDBManager.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.07.2023.
//

import CoreData
import UIKit


//TODO: APP Delegate extension


struct LocalDBManager {
    
    
    /// Struct to model
    /*
     let source: Source?
     let author, title: String?
     let description: String?
     let url: String?
     let urlToImage: String?
     let publishedAt: String?
     let content: String?
     
     Source:
     let id: String?
     let name: String?
     */
     
    
    static let shared = LocalDBManager()
    
    private init() {}
    
    func fetchModel(completion: @escaping ((Result<NewsResponse,NewsAppErrors>) -> Void)) {
        
        var articleArray: [Article] = []
        
        
        
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ArticleModel")
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    
                    articleArray.append(Article(source: .init(id: result.value(forKey: "id") as? String,
                                                              name: result.value(forKey: "name") as? String),
                                                
                                                
                                                //NOTE: source is a diffrent stuct
                                                
                                                author: result.value(forKey: "author") as? String,
                                                title: result.value(forKey: "title") as? String,
                                                description: result.value(forKey: "descriptionN") as? String,
                                                url: result.value(forKey: "url") as? String,
                                                urlToImage: result.value(forKey: "urlToImage") as? String,
                                                publishedAt: result.value(forKey: "publishedAt") as? String,
                                                content: result.value(forKey: "content") as? String
                    ))
                    
                    
                }
                completion(.success(NewsResponse(status: "", totalResults: 0, articles: articleArray)))
            } catch  {
                completion(.failure(.generalError))
            }
            
        }
        
    }
    
    func saveModel(with model: Article) {
                if let appDelegate = UIApplication.shared.delegate as?AppDelegate {
                    let context = appDelegate.persistentContainer.viewContext
                    let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "ArticleModel", into: context)

                    
                    entityDescription.setValue(model.author, forKey: "author")
                    entityDescription.setValue(model.description, forKey: "descriptionN")
                    entityDescription.setValue(model.url, forKey: "url")
                    entityDescription.setValue(model.urlToImage, forKey: "urlToImage")
                    entityDescription.setValue(model.publishedAt, forKey: "publishedAt")
                    entityDescription.setValue(model.content, forKey: "content")
                    entityDescription.setValue(model.title, forKey: "title")
                    
                    //NOTE: source is diffrent struct
                    
                    entityDescription.setValue(model.source?.id, forKey: "id")
                    entityDescription.setValue(model.source?.name, forKey: "name")
                    
                    
                    do{
                        try context.save()
                        print("Saved")
                    }catch{
                        print("Saving Error")
                    }
                }
    }
    
   
    
    
    
}



