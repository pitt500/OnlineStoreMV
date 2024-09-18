//
//  DatabaseClient.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 12/09/24.
//

struct DatabaseClient {
    var saveProducts: ([Product]) -> Void
    var fetchCachedProducts: () -> [Product]
    var clear: () -> Void
}

extension DatabaseClient {
    static let inMemory = Self(
        saveProducts: { products in
            MockedDatabase.shared.cachedProducts = products
        },
        fetchCachedProducts: {
            MockedDatabase.shared.cachedProducts
        },
        clear: {
            MockedDatabase.shared.cachedProducts.removeAll()
        }
    )
    
    // Missing live implementation. This is temporary
    static let live = DatabaseClient.inMemory
}

// Simple in-memory database for caching
class MockedDatabase {
    static let shared = MockedDatabase()
    var cachedProducts: [Product] = []
}
