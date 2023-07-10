//
//  UITableView+Extensions.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.07.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(type: UITableViewCell.Type) {
        
        let bundle = Bundle(for: type.self)
        let nib = UINib(nibName: type.nibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: type.nibName)
    }
}

