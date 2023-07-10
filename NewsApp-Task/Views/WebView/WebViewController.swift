//
//  WebViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    @IBOutlet weak var newsWebView: WKWebView!
    
    let newsUrl: String
    
    init(newsUrl: String){
        self.newsUrl = newsUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsWebView.navigationDelegate = self
        guard let wrappedUrl = URL(string: newsUrl) else {return}
        newsWebView.load(URLRequest(url: wrappedUrl))
        newsWebView.allowsBackForwardNavigationGestures = true
    }
}

extension WebViewController: WKNavigationDelegate {
    
}
