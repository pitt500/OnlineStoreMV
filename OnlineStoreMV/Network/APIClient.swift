//
//  APIClient.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

struct APIClient {
    var fetchProducts: () async throws -> [Product]
    var sendOrder: ([CartItem]) async throws -> String
    var fetchUserProfile: () async throws -> UserProfile
    
    struct Failure: Error, Equatable {}
}

// This is the "live" fact dependency that reaches into the outside world to fetch the data from network.
// Typically this live implementation of the dependency would live in its own module so that the
// main feature doesn't need to compile it.
extension APIClient {
    static let live = Self(
        fetchProducts: {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "https://fakestoreapi.com/products")!)
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        },
        sendOrder: { cartItems in
            let payload = try JSONEncoder().encode(cartItems)
            var urlRequest = URLRequest(url: URL(string: "https://fakestoreapi.com/carts")!)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            
            let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: payload)
            
            guard let httpResponse = (response as? HTTPURLResponse) else {
                throw Failure()
            }
            
            return "Status: \(httpResponse.statusCode)"
        }, 
        fetchUserProfile: {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "https://fakestoreapi.com/users/1")!)
            let profile = try JSONDecoder().decode(UserProfile.self, from: data)
            return profile
        }
    )
#if DEBUG
    static let testSuccess = Self(
        fetchProducts: {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return Product.sample
        },
        sendOrder: { cartItems in
            "OK"
        },
        fetchUserProfile: {
            try await Task.sleep(nanoseconds: 1000)
            return UserProfile(id: 100, email: "test@test.com", firstName: "Test", lastName: "Lopez")
        }
    )
    static let testEmpty = Self(
        fetchProducts: {
            try await Task.sleep(nanoseconds: 1000)
            return []
        },
        sendOrder: { cartItems in
            "OK"
        },
        fetchUserProfile: {
            try await Task.sleep(nanoseconds: 1000)
            return UserProfile(id: 100, email: "test@test.com", firstName: "Test", lastName: "Lopez")
        }
    )
    static let testError = Self(
        fetchProducts: {
            try await Task.sleep(nanoseconds: 1000)
            throw Failure()
        },
        sendOrder: { cartItems in
            "OK"
        },
        fetchUserProfile: {
            try await Task.sleep(nanoseconds: 1000)
            return UserProfile(id: 100, email: "test@test.com", firstName: "Test", lastName: "Lopez")
        }
    )
    
    static let uiTestSuccess = Self(
        fetchProducts: {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return Product.uiTestSample
        },
        sendOrder: { cartItems in
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return "OK"
        },
        fetchUserProfile: {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return UserProfile(id: 100, email: "test@test.com", firstName: "Test", lastName: "Lopez")
        }
    )
#endif
}

// This code is only for demo purposes
extension APIClient {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        Task {
            do {
                let products = try await fetchProducts()
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
