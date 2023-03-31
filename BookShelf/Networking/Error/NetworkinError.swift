//
//  NetworkinError.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import Foundation

enum NetworkinError: Error {
    case invalidURL
    case errorGeneric(_ description: String)
    case invalidResponse
    case invalidPost
    case invalidData
    case errorDecoder
}
