//
//  ProductCell.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 04/03/24.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    @Environment(CartStore.self) private var cartStore
    
    var body: some View {
        VStack {
            AsyncImage(
                url: product.imageURL
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                HStack {
                    if product.hasDiscount {
                        VStack {
                            // Show original price struck through
                            Text("$\(String(format: "%.2f", product.price))")
                                .font(.custom("AmericanTypewriter", size: 16))
                                .strikethrough()
                                .foregroundColor(.gray)
                            
                            // Show discounted price in bold
                            Text("$\(String(format: "%.2f", product.discountedPrice))")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    } else {
                        // If no discount, show normal price
                        Text("$\(String(format: "%.2f", product.price))")
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    AddToCartButton(product: product)
                }
            }
            .font(.custom("AmericanTypewriter", size: 20))
        }
        .padding(20)
    }
}

#if DEBUG
#Preview {
    ProductCell(product: Product.sample.first!)
        .environment(CartStore(logger: .inMemory))
}
#endif
