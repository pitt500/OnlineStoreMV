//
//  CartStoreTest.swift
//  OnlineStoreMVTests
//
//  Created by Pedro Rojas on 07/03/24.
//

import XCTest
import Testing

@testable import OnlineStoreMV

extension Tag {
    @Tag static var substracting: Self
}

struct CartStoreTest {
    var products: [Product] = [
        Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        ),
        Product(
            id: 2,
            title: "test2",
            price: 77.56,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        ),
        Product(
            id: 3,
            title: "test2",
            price: 91.0,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
    ]
    
    @Test("Get total amount to pay as string")
    func totalAmountString() throws {
        
        let cartItems = [
            CartItem(
                product: products[0],
                quantity: 3
            ),
            CartItem(
                product: products[1],
                quantity: 1
            ),
            CartItem(
                product: products[2],
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        #expect(cartStore.totalPriceString == "$628.92")
    }
    
    @Test(.tags(.substracting))
    func quantityFromItemInCart() {
        let cartItems = [
            CartItem(
                product: products[0],
                quantity: 3
            ),
            CartItem(
                product: products[1],
                quantity: 1
            ),
            CartItem(
                product: products[2],
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        cartStore.removeFromCart(product: products[0])
        cartStore.removeFromCart(product: products[2])
        let quantity = cartStore.cartItems.reduce(0) {
            $0 + $1.quantity
        }

        #expect(quantity == 4)
    }
    
    @Test(.tags(.substracting))
    func quantityFromItemInCartUntilMakeItZero() {
        let cartItems = [
            CartItem(
                product: products[0],
                quantity: 3
            ),
            CartItem(
                product: products[1],
                quantity: 1
            ),
            CartItem(
                product: products[2],
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        cartStore.removeFromCart(product: products[0])
        cartStore.removeFromCart(product: products[1])
        cartStore.removeFromCart(product: products[2])
        cartStore.removeFromCart(product: products[2])
        
        let quantity = cartStore.cartItems.reduce(0) {
            $0 + $1.quantity
        }
        
        #expect(quantity == 2)
    }
}

final class CartStoreTest_deprecated: XCTestCase {
    
    func testRemoveProductFromCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 4
            )
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expected: [CartItem] = []
        
        cartStore.removeAllFromCart(product: product1)
        
        let actual = cartStore.cartItems
        
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveAllItemsFromCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let product2 = Product(
            id: 2,
            title: "test2",
            price: 77.56,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let product3 = Product(
            id: 3,
            title: "test2",
            price: 91.0,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 3
            ),
            CartItem(
                product: product2,
                quantity: 1
            ),
            CartItem(
                product: product3,
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expected: [CartItem] = []
        
        cartStore.removeAllItems()
        
        let actual = cartStore.cartItems
        
        XCTAssertEqual(expected, actual)
    }
    
    func testGetQuantityFromAProductInCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 4
            )
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expected = 4
        let actual = cartStore.quantity(for: product1)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testGetQuantityFromAProductThatDoesNotExistInCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let unknownProduct = Product(
            id: 1000,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 4
            )
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expected = 0
        let actual = cartStore.quantity(for: unknownProduct)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testAddQuantityFromExistingItemInCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let product2 = Product(
            id: 2,
            title: "test2",
            price: 77.56,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let product3 = Product(
            id: 3,
            title: "test2",
            price: 91.0,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 3
            ),
            CartItem(
                product: product2,
                quantity: 1
            ),
            CartItem(
                product: product3,
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expectedQuantity = 9
        
        cartStore.addToCart(product: product1)
        cartStore.addToCart(product: product3)
        cartStore.addToCart(product: product3)
        let actualQuantity = cartStore.cartItems.reduce(0) {
            $0 + $1.quantity
        }
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
    func testAddQuantityFromNewItemInCart() {
        let product1 = Product(
            id: 1,
            title: "test1",
            price: 123.12,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let product2 = Product(
            id: 2,
            title: "test2",
            price: 77.56,
            description: "",
            category: "",
            imageURL: URL(string: "www.apple.com")!
        )
        let cartItems = [
            CartItem(
                product: product1,
                quantity: 3
            )
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .testSuccess
        )
        
        let expectedCartItemsCount = 2
        
        cartStore.addToCart(product: product1)
        cartStore.addToCart(product: product2)
        
        let actualCartItemsCount = cartStore.cartItems.count
        
        XCTAssertEqual(expectedCartItemsCount, actualCartItemsCount)
    }
}
