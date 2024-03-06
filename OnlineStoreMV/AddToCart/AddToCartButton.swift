//
//  AddToCartButton.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct AddToCartButton: View {
    @Binding var numberOfItemsInCart: Int
    
    init(_ numberOfItemsInCart: Binding<Int>) {
        self._numberOfItemsInCart = numberOfItemsInCart
    }
    
    var body: some View {
        if numberOfItemsInCart > 0 {
            PlusMinusButton($numberOfItemsInCart)
        } else {
            Button {
                numberOfItemsInCart = 1
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

#Preview {
    AddToCartButton(.constant(2))
}
