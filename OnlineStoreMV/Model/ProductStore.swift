//
//  ProductStore.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

@Observable
class ProductStore {
    var products: [Product]
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .live) {
        self.products = []
        self.apiClient = apiClient
    }
    
    func fetchProducts() async {
        do {
            products = try await apiClient.fetchProducts()
        } catch {
            print(error)
        }
    }
    
}
