//
//  ErroHandleViewBuilder.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.05.2024.
//

import SwiftUI

final class ErroHandleViewBuilder {
    class func showError(from: UIViewController?) {
        DispatchQueue.main.async {
            let view = UIHostingController(rootView: ErrorHandleView())
            from?.navigationController?.present(view, animated: true)
        }
    }
}
