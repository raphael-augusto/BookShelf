//
//  ListOfBooksViewModel.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import Foundation


protocol ListOfBooksViewModelDelegate: AnyObject {
    func didUpdateData()
    func didFinishSuccess()
    func didFinishFailure()
}

protocol ListOfBooksViewModelProtocol {
    var delegate: ListOfBooksViewModelDelegate? { get set }
    
    var dataValueBooks: [BooksData] { get }
    func getDataBooks()
//    func countDataBooks() -> Int
    func getDataBooksIndexPath(indexPath: IndexPath) -> BooksData
}


final class ListOfBooksViewModel: ListOfBooksViewModelProtocol {
   
    //MARK: - Networking and Delegate
    private let networking = Networking()
    weak var delegate: ListOfBooksViewModelDelegate?
    
    
    //MARK: - Variables
    private(set) var dataValueBooks: [BooksData]  = []
    
    
    //MARK: - Init
    init(delegate: ListOfBooksViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    //MARK: - Request api
    func getDataBooks() {
        networking.get(endpoint: .books) { [weak self] (response: Result<ListOfBooks, NetworkinError>) in
            guard let self = self else { return }
            
            switch response {
            case let .success(data):
                self.dataValueBooks = data
//                print("Data Books -> \(self.dataValueBooks)")
                
                self.delegate?.didFinishSuccess()
                
            case let .failure(error):
                print("ERROR GET ListOfBooksViewModel -> \(error.localizedDescription)")
                
                self.delegate?.didFinishFailure()
            }
        }
    }

    //MARK: - TableView
//    func countDataBooks() -> Int {
//        return dataValueBooks.count
//    }
    
    var countDataBooks: Int {
        return dataValueBooks.count
    }
    
    func getDataBooksIndexPath(indexPath: IndexPath) -> BooksData {
        return dataValueBooks[indexPath.row]
    }
      
}
