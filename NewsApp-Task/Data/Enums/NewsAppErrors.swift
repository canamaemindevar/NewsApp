//
//  NewsAppErrors.swift
//  NewsApp-Task
//
//  Created by Emincan Antalyalı on 7.07.2023.
//

import Foundation

enum NewsAppErrors: String, Error {

    case invalidUrl = "InvalidUrl"
    case noData = "No data"
    case invalidRequest = "Invalid request"
    case generalError = "General Error"
    case parsingError = "Parsing Error"
    case localDBError = "Local DB fetching error"
}
