//
//  DiscountProvider.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//


struct DiscountProvider {
    private let discounts: [Int: Double]
    
    init(discounts: [Int: Double]) {
        self.discounts = discounts
    }
    
    func getDiscount(for productID: Int) -> Double? {
        return discounts[productID]
    }
}

extension DiscountProvider {
    // Missing live implementation. This is temporary.
    static let live = DiscountProvider(discounts: [1: 0.1, 2: 0.2])
    static let empty = DiscountProvider(discounts: [:])
}
