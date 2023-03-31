//
//  NetworkingService.swift
//  BookShelf
//
//  Created by Raphael Augusto on 20/03/23.
//

import Foundation

protocol NetworkingServiceProtocol {
    func getBooks(completion: @escaping (Result<[BooksData], NetworkinError>) -> Void)
}

final class NetworkingService: NetworkingServiceProtocol {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
    
    func getBooks(completion: @escaping (Result<[BooksData], NetworkinError>) -> Void) {
        networking.get(endpoint: .books) { (result: Result<[BooksData], NetworkinError>) in
            switch result {
            case .success(let books):
                completion(.success(books))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
