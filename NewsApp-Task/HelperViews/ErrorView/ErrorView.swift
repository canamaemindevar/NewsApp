//
//  ErrorView.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 13.06.2024.
//

import SwiftUI

struct ErrorHandleView: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView.search(text: "Something went wrong.")
        } else {
            ZStack(content: {
                Image(systemName: "magnifyingglass")
                Text("Something went wrong.")
            })
        }
    }
}

#Preview {
    ErrorHandleView()
}
final class ErroHandleViewBuilder {
    class func showError(from: UIViewController?) {
        DispatchQueue.main.async {
            let view = UIHostingController(rootView: ErrorHandleView())
            from?.navigationController?.present(view, animated: true)
        }
    }
}
