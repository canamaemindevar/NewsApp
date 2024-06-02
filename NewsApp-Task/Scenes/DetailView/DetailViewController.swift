//
//  DetailViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import UIKit

protocol DetailViewDisplayLogic: AnyObject {
    func setNew(article: Article)
    func errorHandle()
}

final class DetailViewController: UIViewController {

    //MARK: - Components

    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDetailTextView: UITextView!
    @IBOutlet weak var segueToWebView: UIButton!

    var interactor: DetailViewBusinessLogic?
    var router: (DetailViewRoutingLogic & DetailViewDataPassing)?
    //MARK: - Life Cycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.setPage()
    }
}

//MARK: - Private funcs
private extension DetailViewController {

    @IBAction func segueToWebView(_ sender: UIButton) {
        router?.goToWebView()
    }

    @objc func makeFav() {
        interactor?.checkIsNewFav()
    }

    func setup() {
        let viewController = self
        let interactor = DetailViewInteractor()
        let presenter = DetailViewPresenter()
        let router = DetailViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

//MARK: - DetailViewDisplayLogic
extension DetailViewController: DetailViewDisplayLogic {

    func setNew(article: Article) {
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
        router?.showErrorView()
    }
}
