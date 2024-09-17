//
//  AddToCartButton.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct AddToCartButton: View {
    let product: Product
    @Environment(CartStore.self) private var cartStore
    
    var body: some View {
        if cartStore.quantity(for: product) > 0 {
            PlusMinusButton(product: product)
        } else {
            Button {
                cartStore.addToCart(product: product)
            } label: {
                Text("Add to Cart")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
        }
    }
}

#if DEBUG
#Preview {
    AddToCartButton(product: Product.sample.first!)
        .environment(CartStore(logger: .inMemory))
}
#endif
