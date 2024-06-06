//
//  ViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.07.2023.
//

import UIKit


final class MainViewController: BaseViewController {

    var pageChoice: DataSourceForMainView
    var presenter: MainViewToPresenterInterface?
    var newsArray: [Article]?

    //MARK: - Components
    
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
    
    init(pageChoice: DataSourceForMainView) {
        self.pageChoice = pageChoice
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MainRouter.executeModule(view: self)
        setPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if pageChoice == .FavoritePage {
            presenter?.mainInteractor?.fetchFromDb()
        }
    }
    override func viewWillLayoutSubviews() {
        self.tableView.frame = view.bounds
    }
}

extension MainViewController: MainPresenterToMainViewControllerInterface {
    func updateView(news: NewsResponse?) {
        self.newsArray = news?.articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func handleError() {
      //  router?.showErrorView()
    }

}

//MARK: - Private Functions

private extension MainViewController {
    
    func setPage() {
        tableView.delegate = self
        tableView.dataSource = self
        title = pageChoice.setTitle()
        view.addSubview(tableView)
        
        if pageChoice == .SearchPage {
            makeSearchBar()
            presenter?.mainInteractor?.getHeadLines()
        } else {
            presenter?.mainInteractor?.fetchFromDb()
        }
    }
    
    func makeSearchBar() {
        navigationItem.searchController = searchVc
        searchVc.searchBar.delegate = self
    }
}

//MARK: - TableView funcs

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let arr = newsArray else {return}
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
        presenter?.mainInteractor?.makeQuery(word: text)
    }
}
