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
    
    var article: Article?
    var presenter: DetailViewToPresenterInterface?
    //MARK: - Life Cycle
    
    init(article:Article){
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.interactor?.setPage(new: article)
    }

    @IBAction func segueToWebView(_ sender: UIButton) {
        guard let newsUrl = article?.url else {return}
        presenter?.routeToWebView(newsUrl: newsUrl, view: self)
    }
}

extension DetailViewController: DetailPresenterToViewControllerInterface {
    func setNew(new article: Article) {
        self.newsTitle.text = article.title
        self.newsImageView.setImage(article.urlToImage)
        self.newsAuthorLabel.text = article.author
        self.newsDateLabel.text = article.publishedAt
        self.newsDetailTextView.text = article.description

        let favButton = UIBarButtonItem(image: .add,
                                        style: UIBarButtonItem.Style.plain,
                                        target: self,
                                        action: #selector(makeFav))
        favButton.tintColor = .black
        navigationItem.rightBarButtonItem = favButton
    }

    func errorHandle() {
        presenter?.router?.showError(from: self)
    }
}
//MARK: - Private funcs
private extension DetailViewController {

    @objc private func makeFav() {
        presenter?.interactor?.checkIsNewFav(article: article)
    }
}
