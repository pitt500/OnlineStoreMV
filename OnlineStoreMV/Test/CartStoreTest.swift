//
//  CartStoreTest.swift
//  OnlineStoreMVTests
//
//  Created by Pedro Rojas on 07/03/24.
//

import XCTest

@testable import OnlineStoreMV

final class CartStoreTest: XCTestCase {

    func testTotalAmountString() throws {
        
        let cartItems = [
            CartItem(
                product: Product(
                    id: 1,
                    title: "test1",
                    price: 123.12,
                    description: "",
                    category: "",
                    imageURL: URL(string: "www.apple.com")!
                ),
                quantity: 3
            ),
            CartItem(
                product: Product(
                    id: 2,
                    title: "test2",
                    price: 77.56,
                    description: "",
                    category: "",
                    imageURL: URL(string: "www.apple.com")!
                ),
                quantity: 1
            ),
            CartItem(
                product: Product(
                    id: 3,
                    title: "test2",
                    price: 91.0,
                    description: "",
                    category: "",
                    imageURL: URL(string: "www.apple.com")!
                ),
                quantity: 2
            ),
        ]
        let cartStore = CartStore(
            cartItems: cartItems,
            apiClient: .test
        )
        
        let expected = "$628.92"
        let actual = cartStore.totalPriceString
        
        XCTAssertEqual(actual, expected, "Actual result is not the same as expected")
    }
    
    func testSubstractQuantityFromItemInCart() {
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
            apiClient: .test
        )
        
        let expectedQuantity = 4
        
        cartStore.removeFromCart(product: product1)
        cartStore.removeFromCart(product: product3)
        let actualQuantity = cartStore.cartItems.reduce(0) {
            $0 + $1.quantity
        }
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
    func testSubstractQuantityFromItemInCartUntilMakeItZero() {
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
            apiClient: .test
        )
        
        let expectedQuantity = 2
        
        cartStore.removeFromCart(product: product1)
        cartStore.removeFromCart(product: product2)
        cartStore.removeFromCart(product: product3)
        cartStore.removeFromCart(product: product3)
        
        let actualQuantity = cartStore.cartItems.reduce(0) {
            $0 + $1.quantity
        }
        
        XCTAssertEqual(expectedQuantity, actualQuantity)
    }
    
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
            apiClient: .test
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
            apiClient: .test
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
            apiClient: .test
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
            apiClient: .test
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
            apiClient: .test
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
            apiClient: .test
        )
        
        let expectedCartItemsCount = 2
        
        cartStore.addToCart(product: product1)
        cartStore.addToCart(product: product2)
        
        let actualCartItemsCount = cartStore.cartItems.count
        
        XCTAssertEqual(expectedCartItemsCount, actualCartItemsCount)
    }
}
