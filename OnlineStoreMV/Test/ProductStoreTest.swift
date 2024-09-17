//
//  ProductStoreTest.swift
//  OnlineStoreMVTests
//
//  Created by Pedro Rojas on 09/08/24.
//

import XCTest
import Testing

@testable import OnlineStoreMV

struct ProductStoreTest {
    
    @Test
    func fetchThreeProductsFromApiAndDatabase() async throws {
        let logger = Logger.fileLogging(fileName: "productStore_test.log")
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .live,
            discountCalculator: .init(discountProvider: .demo),
            logger: logger
        )
        
        logger.clear()
        try #require(MockedDatabase.shared.cachedProducts.isEmpty, "Cannot test fetching products from API when database is not empty")
        try #require(productStore.products.isEmpty, "Cannot test fetching products from API when products are not empty")
        try #require(logger.loggedMessages.isEmpty, "Logger is not empty")
        
        // Fetching products from API
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        #expect(products.count == 3)
        #expect(MockedDatabase.shared.cachedProducts.count == 3)
        #expect(logger.loggedMessages.count == 2)
        
        let lastLoggedMessageFromAPI = try #require(logger.loggedMessages.last)
        #expect(lastLoggedMessageFromAPI.contains("Fetched products from API and applied discounts."))
        
        // Fetching products from Cache
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        #expect(products.count == 3)
        #expect(MockedDatabase.shared.cachedProducts.count == 3)
        #expect(logger.loggedMessages.count == 4)
        
        let lastLoggedMessageFromCache = try #require(logger.loggedMessages.last)
        #expect(lastLoggedMessageFromCache.contains("Fetched products from cache."))
        
        logger.clear()
        #expect(logger.loggedMessages.isEmpty, "Logger is not empty")
    }
    
    @Test
    func testFetchThreeProductsFromAPIDeprecated() async throws {
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory,
            discountCalculator: .init(discountProvider: .demo),
            logger: .inMemory
        )
        
        do {
            let products = try await withCheckedThrowingContinuation { continuation in
                productStore.fetchProducts { result in
                    switch result {
                    case .success(let products):
                        continuation.resume(returning: products)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            #expect(products.count == 3)
        } catch {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
        }
    }
}

final class ProductStoreTest_deprecated: XCTest {
    func testFetchThreeProductsFromAPI() async {
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory,
            discountCalculator: .init(discountProvider: .demo),
            logger: .inMemory
        )
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            XCTFail("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        XCTAssertEqual(products.count, 3)
    }
    
    func testFetchThreeProductsFromAPIDeprecated() {
        let productStore = ProductStore(
            apiClient: .testError,
            databaseClient: .inMemory,
            discountCalculator: .init(discountProvider: .demo),
            logger: .inMemory
        )
        
        let expectation = XCTestExpectation(description: "Fetch products")
        
        productStore.fetchProducts { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 3)
            case .failure(let error):
                XCTFail("Expected .loaded state but got \(productStore.loadingState)")
            }
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 1)
    }
}
