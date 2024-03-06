//
//  ProductCell.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 04/03/24.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    @Binding var numberOfItemsInCart: Int
    
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
                    Text("$\(product.price.description)")
                        .font(.custom("AmericanTypewriter", size: 25))
                        .fontWeight(.bold)
                    Spacer()
                    AddToCartButton($numberOfItemsInCart)
                }
            }
            .font(.custom("AmericanTypewriter", size: 20))
        }
        .padding(20)
    }
}

#Preview {
    ProductCell(product: Product.sample.first!, numberOfItemsInCart: .constant(2))
}
