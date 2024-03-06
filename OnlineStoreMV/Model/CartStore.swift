//
//  CartStore.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

@Observable
class CartStore {
    var cartItems: [CartItem]
    
    init() {
        cartItems = []
    }
}
