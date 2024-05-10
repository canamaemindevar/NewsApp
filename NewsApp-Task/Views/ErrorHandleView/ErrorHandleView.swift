//
//  ErrorHandleView.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 10.05.2024.
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
