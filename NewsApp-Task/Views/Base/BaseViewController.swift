//
//  BaseViewController.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 6.07.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
    deinit {
        let type = Swift.type(of: self)
        print("\(type) DEALLOCATED")
    }
}
