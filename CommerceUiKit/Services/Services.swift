//
//  Services.swift
//  CommerceUiKit
//
//  Created by Bora Erdem on 30.08.2022.
//

import Foundation

import Foundation
import Combine

struct Services{
    static var shared = Services()
    
    
    mutating func getAllCategories() -> AnyPublisher<[Category], Error>{
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories") else {fatalError("url olmadı")}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                guard
                     let response = response as? HTTPURLResponse,
                     response.statusCode >= 200 && response.statusCode<300 else{
                     throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Category].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    func getCategoryProducts(categoryId: String) -> AnyPublisher<[Item], Error>{
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/categories/\(categoryId)/products") else {fatalError("category items gelmedi")}
                return URLSession.shared.dataTaskPublisher(for: url)
                    .receive(on: DispatchQueue.main)
                    .tryMap { data, response in
                        guard
                             let response = response as? HTTPURLResponse,
                             response.statusCode >= 200 && response.statusCode<300 else{
                             throw URLError(.badServerResponse)
                        }
                        return data
                    }
                    .decode(type: [Item].self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
    }
    
    func getOfferProducts() -> AnyPublisher<[Item], Error>{
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products?offset=0&limit=10") else {fatalError("category items gelmedi")}
                return URLSession.shared.dataTaskPublisher(for: url)
                    .receive(on: DispatchQueue.main)
                    .tryMap { data, response in
                        guard
                             let response = response as? HTTPURLResponse,
                             response.statusCode >= 200 && response.statusCode<300 else{
                             throw URLError(.badServerResponse)
                        }
                        return data
                    }
                    .decode(type: [Item].self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
    }
    
}
