//
//  PlusMinusButton.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct PlusMinusButton: View {
    @Binding var numberOfItemsInCart: Int
    
    init(_ numberOfItemsInCart: Binding<Int>) {
        self._numberOfItemsInCart = numberOfItemsInCart
    }
    
    var body: some View {
        HStack {
            Button {
                numberOfItemsInCart -= 1
            } label: {
                Text("-")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
            
            Text(numberOfItemsInCart.description)
                .padding(5)
            
            Button {
                numberOfItemsInCart += 1
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


#Preview {
    PlusMinusButton(.constant(2))
}
