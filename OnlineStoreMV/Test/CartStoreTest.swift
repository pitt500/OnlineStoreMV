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
    @Tag static var adding: Self
    @Tag static var substracting: Self
    @Tag static var removing: Self
    @Tag static var quantity: Self
}

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

struct CartStoreTest {
    
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
    
    @Suite("Substracting Quantity on Cart Items",.tags(.substracting))
    struct SubstractingTest {

        @Test
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
        
        @Test
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
    
    @Suite("Removing Items from Cart", .tags(.removing))
    struct RemovingTest {
        
        @Test
        func oneProductFromCart() {
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
            
            cartStore.removeAllFromCart(product: product1)
            
            #expect(cartStore.cartItems.isEmpty)
        }
        
        @Test
        func allItemsFromCart() {
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
            
            cartStore.removeAllItems()
            
            #expect(cartStore.cartItems.isEmpty)
        }
    }
    
    @Suite(
        "Test quantity after some operations",
        .tags(.quantity)
    )
    struct QuantityTest {
        @Test func productInCart() {
            let cartItems = [
                CartItem(
                    product: products[0],
                    quantity: 4
                )
            ]
            let cartStore = CartStore(
                cartItems: cartItems,
                apiClient: .testSuccess
            )
            
            let quantity = cartStore.quantity(for: products[0])
            #expect(quantity == 4)
        }
        
        @Test func nonExistingProductInCart() {
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
                    product: products[0],
                    quantity: 4
                )
            ]
            let cartStore = CartStore(
                cartItems: cartItems,
                apiClient: .testSuccess
            )

            let quantity = cartStore.quantity(for: unknownProduct)
            
            #expect(quantity == 0)
        }
    }
    
    @Suite("Adding Items To Cart", .tags(.adding))
    struct AddingToCartTest {
        @Test
        func addQuantityFromExistingItem() {
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
            
            cartStore.addToCart(product: products[0])
            cartStore.addToCart(product: products[2])
            cartStore.addToCart(product: products[3])
            let quantity = cartStore.cartItems.reduce(0) {
                $0 + $1.quantity
            }
            
            #expect(quantity == 9)
        }
        
        @Test
        func addQuantityFromNewItem() {
            let cartItems = [
                CartItem(
                    product: products[0],
                    quantity: 3
                )
            ]
            let cartStore = CartStore(
                cartItems: cartItems,
                apiClient: .testSuccess
            )
                        
            cartStore.addToCart(product: products[0])
            cartStore.addToCart(product: products[1])
            
            #expect(cartStore.cartItems.count == 2)
        }
    }
}
