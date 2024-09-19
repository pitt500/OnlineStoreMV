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
    func fetchThreeProductsFromAPI() async {
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory,
            discountCalculator: .init(discountProvider: .empty),
            logger: .inMemory
        )
        await productStore.fetchProducts()
        
        guard case .loaded(let products) = productStore.loadingState else {
            Issue.record("Expected .loaded state but got \(productStore.loadingState)")
            return
        }
        
        #expect(products.count == 3)
    }
    
    @Suite
    struct IntegrationTests {
        func createTempFileURLForTest(
            named testName: String = #function
        ) -> URL {
            let tempDirectory = FileManager.default.temporaryDirectory
            let fileURL = tempDirectory.appendingPathComponent(testName)
            
            //Ensuring the previous temp file is deleted.
            try? FileManager.default.removeItem(atPath: fileURL.path)
            
            return fileURL
        }
        
        @Test
        func fetchThreeProductsFromCache() async throws {
            let logger = Logger.fileLogging(fileURL: createTempFileURLForTest())
            let database = DatabaseClient.inMemory
            let productStore = ProductStore(
                apiClient: .testSuccess,
                databaseClient: database,
                discountCalculator: .init(discountProvider: .live),
                logger: logger
            )
            
            logger.clear()
            try #require(logger.loggedMessages.isEmpty, "Logger is not empty")
            
            database.clear()
            try #require(database.fetchCachedProducts().isEmpty, "Cannot test fetching products when database is not empty")
            try #require(productStore.products.isEmpty, "Cannot test fetching products when products are not empty")
            
            // Fetching products from API
            await productStore.fetchProducts()
            
            guard case .loaded(let products) = productStore.loadingState else {
                Issue.record("Expected .loaded state but got \(productStore.loadingState)")
                return
            }
            
            #expect(products.count == 3)
            #expect(products[0].hasDiscount)
            #expect(products[1].hasDiscount)
            #expect(!products[2].hasDiscount) // Regular price
            
            #expect(database.fetchCachedProducts().count == 3)
            
            let lastLoggedMessageFromAPI = try #require(logger.loggedMessages.last)
            #expect(lastLoggedMessageFromAPI.contains("Fetched products from API and applied discounts."))
            
            // Fetching products from Cache
            await productStore.fetchProducts()
            
            guard case .loaded(let products) = productStore.loadingState else {
                Issue.record("Expected .loaded state but got \(productStore.loadingState)")
                return
            }
            
            #expect(products.count == 3)
            #expect(products[0].hasDiscount)
            #expect(products[1].hasDiscount)
            #expect(!products[2].hasDiscount)
            
            #expect(database.fetchCachedProducts().count == 3)
            
            let lastLoggedMessageFromCache = try #require(logger.loggedMessages.last)
            #expect(lastLoggedMessageFromCache.contains("Fetched products from cache."))
        }
    }
    
    @Test
    func testFetchThreeProductsFromAPIDeprecated() async throws {
        let productStore = ProductStore(
            apiClient: .testSuccess,
            databaseClient: .inMemory,
            discountCalculator: .init(discountProvider: .live),
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
            discountCalculator: .init(discountProvider: .live),
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
            discountCalculator: .init(discountProvider: .live),
            logger: .inMemory
        )
        
        let expectation = XCTestExpectation(description: "Fetch products")
        
        productStore.fetchProducts { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 3)
            case .failure(let error):
                XCTFail("Expected .loaded state but got \(productStore.loadingState). Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 1)
    }
}
