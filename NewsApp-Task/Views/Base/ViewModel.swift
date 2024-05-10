//
//  ViewModel.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.05.2024.
//

import Foundation

class ViewModel: NSObject {

    deinit {
        let type = Swift.type(of: self)
        print("\(type) DEALLOCATED")
    }
}
