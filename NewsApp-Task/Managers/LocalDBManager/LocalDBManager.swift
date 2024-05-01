//
//  LocalDBManager.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.07.2023.
//

import CoreData
import UIKit

struct LocalDBManager {

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
    func deleteModel(with model: Article) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<ArticleModel> = ArticleModel.fetchRequest()
            if let url = model.url {
                fetchRequest.predicate = NSPredicate(format: "url == %@", url)

                do {
                    let result = try context.fetch(fetchRequest)

                    for data in result {
                        context.delete(data)
                        print("Deleted")
                    }

                    try context.save()
                } catch {
                    print("Deleting Error: \(error)")
                }
            } else {
                print("URL is nil, cannot delete the model.")
            }
        }
    }
}
