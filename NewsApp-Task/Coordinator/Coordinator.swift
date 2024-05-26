//
//  Coordinator.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 26.05.2024.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get}
    var navigationController: UINavigationController { get set }

    func start()
}
