//
//  ListOfBooksViewModel.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import Foundation


protocol ListOfBooksViewModelOutput: AnyObject {
    func didFinishSuccess()
    func didFinishFailure(message: String)
}

protocol ListOfBooksViewModelInput {
    func fetchBooks()
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func getTitleForHeaderInSection(section: Int) -> String?
    func getCellForRowAt(indexPath: IndexPath) -> BooksData?
}


final class ListOfBooksViewModel: ListOfBooksViewModelInput {
    
    
    //MARK: - Networking and Delegate
    private let networkingService: NetworkingServiceProtocol
    weak var delegate: ListOfBooksViewModelOutput?
    
    
    //MARK: - Variables
    private(set) var booksData: [BooksData]  = []
    private(set) var groupedBooksByCategory: [String: [BooksData]] = [:]
    private(set) var bookTitle: [BooksData] = []
    
    
    //MARK: - Init
    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    
    //MARK: - Request api
    func fetchBooks() {
        networkingService.getBooks { [weak self] (result: Result<[BooksData], NetworkinError>) in
            switch result {
            case .success(let books):
                self?.booksData = books
                self?.groupingOfBooksByCategories()
                self?.delegate?.didFinishSuccess()
                
            case .failure(let error):
                self?.delegate?.didFinishFailure(message: "Error ListOfBooksViewModel -> \(error)")
            }
        }
    }
    
    //função para agrupamento por categorio do livro
    private func groupingOfBooksByCategories() {
        for book in booksData {
            if let category = book.category {
                if groupedBooksByCategory[category] != nil {
                    groupedBooksByCategory[category]?.append(book)
                } else {
                    groupedBooksByCategory[category] = [book]
                }
            }
        }
    }
    
    
    //MARK: - TableView
    func getNumberOfSections() -> Int {
        return groupedBooksByCategory.count
    }
    
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        let sectionKey = Array(groupedBooksByCategory.keys)[section]
        return groupedBooksByCategory[sectionKey]?.count ?? 0
    }
    
    
    func getTitleForHeaderInSection(section: Int) -> String? {
        let sectionKey = Array(groupedBooksByCategory.keys)[section]
        return groupedBooksByCategory[sectionKey]?.first?.category
    }
    
    
    func getCellForRowAt(indexPath: IndexPath) -> BooksData? {
        let indexPathSection = indexPath.section
        let indexPathRow = indexPath.row

        let sectionKey = Array(groupedBooksByCategory.keys)[indexPathSection]

        guard let booksDataArray = groupedBooksByCategory[sectionKey], indexPathRow < booksDataArray.count else { return nil }

        return booksDataArray[indexPathRow]
    }

    

}
