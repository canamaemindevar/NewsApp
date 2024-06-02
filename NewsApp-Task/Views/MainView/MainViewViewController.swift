//
//  MainViewViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 1.06.2024.
//

import UIKit

protocol MainViewDisplayLogic: AnyObject {
    func updateView(news: MainViewModels.Case.ViewModel?)
    func handleError()
}

final class MainViewController: BaseViewController {
    
    var interactor: MainViewBusinessLogic?
    var router: (MainViewRoutingLogic & MainViewDataPassing)?

 //   var pageChoice: DataSourceForMainView = .SearchPage
    var newsArray: [Article]?
    // MARK: Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .systemGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 0
        tableView.register(type: NewsTableViewCell.self)
        return tableView
    }()

    private let searchVc = UISearchController(searchResultsController: nil)

    // MARK: Object lifecycle


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
        setPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        if router?.dataStore?.pageChoice == .FavoritePage {
            interactor?.fetchFromDb()
        }
    }
    override func viewWillLayoutSubviews() {
        self.tableView.frame = view.bounds
    }
}

private extension MainViewController {
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainViewInteractor()
        let presenter = MainViewPresenter()
        let router = MainViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func startQuery(){
        interactor?.getHeadLines()
    }

    func setPage() {
        tableView.delegate = self
        tableView.dataSource = self
        title = router?.dataStore?.pageChoice?.setTitle()
        view.addSubview(tableView)

        if router?.dataStore?.pageChoice == .SearchPage {
            makeSearchBar()
            interactor?.getHeadLines()
        } else {
            interactor?.fetchFromDb()
        }
    }

    func makeSearchBar() {
        navigationItem.searchController = searchVc
        searchVc.searchBar.delegate = self
    }
}

extension MainViewController: MainViewDisplayLogic {
    func updateView(news: MainViewModels.Case.ViewModel?) {
        self.newsArray = news?.news
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func handleError() {

    }
}
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let arr =  newsArray else {return}
        let article = arr[indexPath.row]
        let detailVc = DetailViewController(article: article)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray?.count ?? 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.nibName) as! NewsTableViewCell
        guard let arr = newsArray else {return UITableViewCell()}
        cell.article = arr[indexPath.row]

        return cell
    }
}

//MARK: - SearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let text = searchBar.text, !text.isEmpty else {return }
        interactor?.makeQuery(word: text)
    }
}
