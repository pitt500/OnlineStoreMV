//
//  CartItem.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation

struct CartItem {
    let product: Product
    let quantity: Int
}

extension CartItem: Encodable {
    private enum CartItemsKey: String, CodingKey {
        case productId
        case quantity
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CartItemsKey.self)
        try container.encode(product.id, forKey: .productId)
        try container.encode(quantity, forKey: .quantity)
    }
}

