//
//  PlusMinusButton.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct PlusMinusButton: View {
    let product: Product
    @Environment(CartStore.self) private var cartStore
    
    var body: some View {
        HStack {
            Button {
                cartStore.removeFromCart(product: product)
            } label: {
                Text("-")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
            
            Text(cartStore.quantity(for: product).description)
                .padding(5)
            
            Button {
                cartStore.addToCart(product: product)
            } label: {
                Text("+")
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
    PlusMinusButton(product: Product.sample.first!)
        .environment(CartStore())
        
}
#endif
