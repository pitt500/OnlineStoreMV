//
//  CartStore.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

@Observable
class CartStore {
    enum SendOrderStatus: Equatable {
        case notStarted
        case loading
        case success
        case error
    }
    
    var cartItems: [CartItem] = []
    private let apiClient: APIClient
    var sendOrderStatus = SendOrderStatus.notStarted
    
    init(apiClient: APIClient = .live) {
        self.apiClient = apiClient
    }
    
    var isSendingOrder: Bool {
        sendOrderStatus == .loading
    }
    
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
    
    func removeAllItems() {
        cartItems.removeAll()
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
    
    func sendOrder() async {
        
        do {
            sendOrderStatus = .loading
            _ = try await apiClient.sendOrder(cartItems)
            sendOrderStatus = .success
        } catch {
            sendOrderStatus = .error
            print("Error sending order: \(error.localizedDescription)")
        }
    }
}
