//
//  CartItem+Sample.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 04/05/24.
//

import Foundation

extension CartItem {
    static let sample = Product.sample.map {
        CartItem(product: $0, quantity: 2)
    }
}
