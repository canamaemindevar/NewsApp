//
//  UITableViewCell+Extensions.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.07.2023.
//

import UIKit

extension UITableViewCell {
    
    static var nibName: String {
        return String(describing: self.self)
    }
}
