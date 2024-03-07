//
//  CartStore.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

@Observable
class CartStore {
    var cartItems: [CartItem] = []
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(
                CartItem(
                    product: product,
                    quantity: 1
                )
            )
        }
    }
    
    func removeFromCart(product: Product) {
        guard let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) else { return }
            
            
        if cartItems[index].quantity > 1 {
            cartItems[index].quantity -= 1
        } else {
            cartItems.remove(at: index)
        }
    }
    
    func removeAllFromCart(product: Product) {
        guard let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) else { return }
        
        cartItems.remove(at: index)
    }
    
    func totalAmount() -> Double {
        cartItems.reduce(0.0) {
            $0 + ($1.product.price * Double($1.quantity))
        }
    }
    
    var totalPriceString: String {
        let roundedValue = round(totalAmount() * 100) / 100.0
        return "$\(roundedValue)"
    }
    
    func numberOfItemsInCart(product: Product) -> Int {
        cartItems.filter {
            $0.product.id == product.id
        }.count
    }
    
    func quantity(for product: Product) -> Int {
        cartItems.first {
            $0.product.id == product.id
        }?.quantity ?? 0
    }
}
