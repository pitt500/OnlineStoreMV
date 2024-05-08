//
//  CartCell.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 06/03/24.
//

import SwiftUI

struct CartCell: View {
    let cartItem: CartItem
    @Environment(CartStore.self) private var cartStore
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(
                    url: cartItem.product.imageURL
                ) {
                    $0
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
                VStack(alignment: .leading) {
                    Text(cartItem.product.title)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    HStack {
                        Text("$\(cartItem.product.price.description)")
                            .font(.custom("AmericanTypewriter", size: 25))
                            .fontWeight(.bold)
                    }
                }
                
            }
            ZStack {
                Group {
                    Text("Quantity: ")
                    +
                    Text("\(cartItem.quantity)")
                        .fontWeight(.bold)
                }
                .font(.custom("AmericanTypewriter", size: 25))
                HStack {
                    Spacer()
                    Button {
                        cartStore.removeAllFromCart(
                            product: cartItem.product
                        )
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .font(.custom("AmericanTypewriter", size: 20))
        .padding([.bottom, .top], 10)
    }
}

#if DEBUG
#Preview {
    CartCell(
        cartItem: CartItem(
            product: Product.sample.first!,
            quantity: 2
        )
    )
    .environment(CartStore())
}
#endif
