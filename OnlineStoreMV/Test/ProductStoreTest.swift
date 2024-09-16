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
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory
        )
        
        try #require(MockedDatabase.shared.cachedProducts.isEmpty, "Cannot test fetching products from API when database is not empty")
        try #require(productStore.products.isEmpty, "Cannot test fetching products from API when products are not empty")
        
        // Fetching products from API
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        #expect(products.count == 3)
        #expect(MockedDatabase.shared.cachedProducts.count == 3)
        
        // Fetching products from Cache
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        #expect(products.count == 3)
        #expect(MockedDatabase.shared.cachedProducts.count == 3)
    }
    
    @Test
    func testFetchThreeProductsFromAPIDeprecated() async throws {
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory
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
            databaseClient: .inMemory
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
            databaseClient: .inMemory
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
