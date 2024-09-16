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
    var loadingState: LoadingState = .notStarted
        
    private let apiClient: APIClient
    private let databaseClient: DatabaseClient
    private let discountCalculator: DiscountCalculator
    
    init(
        apiClient: APIClient = .live,
        databaseClient: DatabaseClient = .live,
        discountCalculator: DiscountCalculator
    ) {
        self.products = []
        self.apiClient = apiClient
        self.databaseClient = databaseClient
        self.discountCalculator = discountCalculator
    }
    
    enum LoadingState {
        case notStarted
        case loading
        case loaded(result: [Product])
        case empty
        case error(message: String)
    }
    
    @MainActor
    func fetchProducts() async {
        loadingState = .loading
        
        // Try fetching from the cache first
        let cachedProducts = databaseClient.fetchCachedProducts()
        guard cachedProducts.isEmpty else {
            let discountedProducts = discountCalculator.applyDiscount(to: cachedProducts)
            products = discountedProducts
            loadingState = .loaded(result: discountedProducts)
            return
        }
        
        do {
            var fetchedProducts = try await apiClient.fetchProducts()
            fetchedProducts = discountCalculator.applyDiscount(to: fetchedProducts)
            products = fetchedProducts
            loadingState = products.isEmpty ? .empty : .loaded(result: products)
            
            // Save fetched products to the database
            databaseClient.saveProducts(products)
        } catch {
            loadingState = .error(message: error.localizedDescription)
        }
    }
    
    // This code is for demo purpuses
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        apiClient.fetchProducts(completion: completion)
    }
    
}
