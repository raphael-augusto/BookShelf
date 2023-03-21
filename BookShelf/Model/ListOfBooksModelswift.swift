//
//  ListOfBooksModelswift.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import Foundation


// MARK: - WelcomeElement
struct BooksData: Codable {
    let author: String?
    let category: String?
    let id: Int?
    let isHighlight: Bool?
    let photo: String
    let price: Int?
    let stock: Int?
    let title: String?
}

typealias ListOfBooks = [BooksData]

