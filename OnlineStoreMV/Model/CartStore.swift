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
    private let logger: Logger
    var sendOrderStatus = SendOrderStatus.notStarted
    
    init(
        cartItems: [CartItem] = [],
        apiClient: APIClient = .live,
        logger: Logger
    ) {
        self.cartItems = cartItems
        self.apiClient = apiClient
        self.logger = logger
    }
    
    var isSendingOrder: Bool {
        sendOrderStatus == .loading
    }
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) {
            cartItems[index].quantity += 1
            logger.log("Increased quantity of \(product.title) to \(cartItems[index].quantity).")
        } else {
            cartItems.append(
                CartItem(
                    product: product,
                    quantity: 1
                )
            )
            logger.log("Added \(product.title) to cart.")
        }
    }
    
    func removeFromCart(product: Product) {
        guard let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) else { return }
            
            
        if cartItems[index].quantity > 1 {
            cartItems[index].quantity -= 1
            logger.log("Decreased quantity of \(product.title) to \(cartItems[index].quantity).")
        } else {
            cartItems.remove(at: index)
            logger.log("Removed \(product.title) from cart.")
        }
    }
    
    func removeAllFromCart(product: Product) {
        guard let index = cartItems.firstIndex(
            where: { $0.product.id == product.id }
        ) else { return }
        
        cartItems.remove(at: index)
        logger.log("Removed all items of \(product.title) from cart.")
    }
    
    func removeAllItems() {
        cartItems.removeAll()
        logger.log("Removed all items from cart.")
    }
    
    func totalAmount() -> Double {
        let total = cartItems.reduce(0.0) { total, cartItem in
            total + (cartItem.product.discountedPrice * Double(cartItem.quantity))
        }
        logger.log("Calculated total amount: \(total).")
        return total
    }
    
    var totalPriceString: String {
        let roundedValue = round(totalAmount() * 100) / 100.0
        logger.log("Formatted total price: \(roundedValue).")
        return "$\(roundedValue)"
    }
    
    func quantity(for product: Product) -> Int {
        let quantity = cartItems.first { $0.product.id == product.id }?.quantity ?? 0
        logger.log("Retrieved quantity for \(product.title): \(quantity).")
        return quantity
    }
    
    func sendOrder() async {
        do {
            sendOrderStatus = .loading
            logger.log("Started sending order.")
            
            _ = try await apiClient.sendOrder(cartItems)
            
            sendOrderStatus = .success
            logger.log("Order sent successfully.")
        } catch {
            sendOrderStatus = .error
            logger.log("Error sending order: \(error.localizedDescription).")
            print("Error sending order: \(error.localizedDescription)")
        }
    }
}
