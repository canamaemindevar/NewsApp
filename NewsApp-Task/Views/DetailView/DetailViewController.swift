//
//  DetailViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    //MARK: - Components
    
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDetailTextView: UITextView!
    @IBOutlet weak var segueToWebView: UIButton!
    
    var article: Article
    var localDBManager: LocalDBManagerInterface?
    //MARK: - Life Cycle
    
    init(article:Article, localDBManager: LocalDBManagerInterface? = LocalDBManager()){
        self.article = article
        self.localDBManager = localDBManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNew()
    }

    @IBAction func segueToWebView(_ sender: UIButton) {
        guard let newsUrl = article.url else {return}
        let webVc = WebViewController(newsUrl: newsUrl)
        self.navigationController?.pushViewController(webVc, animated: true)
    }
}
//MARK: - Private funcs
private extension DetailViewController {
    private func setNew() {
        self.newsTitle.text = article.title
        self.newsImageView.setImage(article.urlToImage)
        self.newsAuthorLabel.text = article.author
        self.newsDateLabel.text = formatDate(date: article.publishedAt)
        if article.description == nil {
            self.newsDetailTextView.text = "Details are coming soon"
        } else {
            self.newsDetailTextView.text = article.description
        }
        
        let favButton = UIBarButtonItem(image: .add,
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(makeFav))
        favButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = favButton
        
    }
    
    @objc private func makeFav() {
        
         localDBManager?.fetchModel(completion: { response in
             switch response {
             case .success(let success):
                 
                 guard let articless = success.articles else {return}
                 if self.containsArticle(articless, self.article) {

                     self.localDBManager?.deleteModel(with: self.article)

                 }else {
                     self.localDBManager?.saveModel(with: self.article)
                 }
                 
             case .failure(_):
                break
             }
        })

    }
    
  private  func containsArticle(_ array: [Article], _ search: Article) -> Bool {
        for art in array {
            if art.title == search.title && art.url == search.url {
                return true
            }
        }
        return false
    }

    private func formatDate(date: String?) -> String? {
        guard let dateString = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "tr_TR")

        guard let inputDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "tr_TR")
        outputFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
        return outputFormatter.string(from: inputDate)
    }

}
