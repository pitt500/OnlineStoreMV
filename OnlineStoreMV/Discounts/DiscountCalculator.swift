//
//  DiscountCalculator.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 16/09/24.
//

struct DiscountCalculator {
    let discountProvider: DiscountProvider
    
    func applyDiscountIfEligible(to product: Product) -> Product {
        var discountedProduct = product
        
        if let discountPercentage = discountProvider.getDiscount(for: product.id) {
            guard discountPercentage >= 0.0 && discountPercentage <= 1.0 else {
                print("Error: Discount percentage for product \(product.id) is out of range")
                return product
            }
            
            discountedProduct.price = product.price * (1 - discountPercentage)
            discountedProduct.hasDiscount = true
        }
        
        return discountedProduct
    }
    
    func applyDiscount(to products: [Product]) -> [Product] {
        return products.map { applyDiscountIfEligible(to: $0) }
    }
}
