//
//  Networking.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit
import Foundation


protocol NetworkingProtocol {
    func get<T: Decodable> (endpoint: NetworkingEndPoint, completion: @escaping (Result<T, NetworkinError>) -> Void)
}

struct Networking: NetworkingProtocol {
    
    private var session: URLSession
    private let baseURL = "https://mockend.com/policante/rest-api/"
    
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func get<T>(
        endpoint: NetworkingEndPoint,
        completion: @escaping (Result<T, NetworkinError>) -> Void
    ) where T : Decodable {
        
        guard let url = URL(string: baseURL + "\(endpoint.rawValue)") else {
            return completion(.failure(.invalidURL))
        }
        
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                return completion(.failure(.errorGeneric(error.localizedDescription)))
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                return completion(.failure(.invalidResponse))
            }
            
            
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
    
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                
                if let result = try? decoder.decode(T.self, from: data) {
                    completion(.success(result))
                    
                } else {
                    print("-- Service --")
                    completion(.failure(.errorDecoder))
                }
            }
        }
        
        dataTask.resume()
    }
    
}
