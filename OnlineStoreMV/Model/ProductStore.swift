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
    private let logger: Logger
    
    init(
        apiClient: APIClient = .live,
        databaseClient: DatabaseClient = .live,
        discountCalculator: DiscountCalculator,
        logger: Logger
    ) {
        self.products = []
        self.apiClient = apiClient
        self.databaseClient = databaseClient
        self.discountCalculator = discountCalculator
        self.logger = logger
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
        logger.log("Started fetching products.")
        
        // Try fetching from the cache first
        let cachedProducts = databaseClient.fetchCachedProducts()
        guard cachedProducts.isEmpty else {
            //let discountedProducts = discountCalculator.applyDiscount(to: cachedProducts)
            products = cachedProducts
            loadingState = .loaded(result: cachedProducts)
            logger.log("Fetched products from cache.")
            return
        }
        
        do {
            var fetchedProducts = try await apiClient.fetchProducts()
            fetchedProducts = discountCalculator.applyDiscount(to: fetchedProducts)
            products = fetchedProducts
            loadingState = products.isEmpty ? .empty : .loaded(result: products)
            
            // Save fetched products to the database
            databaseClient.saveProducts(products)
            logger.log("Fetched products from API and applied discounts.")
        } catch {
            loadingState = .error(message: error.localizedDescription)
            logger.log("Error fetching products: \(error.localizedDescription).")
        }
    }
    
    // This code is for demo purpuses
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        apiClient.fetchProducts(completion: completion)
    }
    
}
