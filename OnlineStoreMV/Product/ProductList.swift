//
//  ProductList.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct ProductList: View {
    @Environment(\.productStore) var productStore
    @Environment(\.cartStore) var cartStore
    
    var body: some View {
        NavigationView {
            Group {
                switch productStore.loadingState {
                case .loading, .notStarted:
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .task {
                            await productStore.fetchProducts()
                        }
                case .error(let message):
                    Text(message)
                case .empty:
                    Text("No Data Found")
                case .loaded(let products):
                    List(products) { product in
                        ProductCell(
                            product: product
                        )
                        .environment(cartStore)
                    }
                }
            }
            .navigationTitle("Products")
            .refreshable {
                await productStore.fetchProducts()
            }
        }
        
    }
}

#Preview {
    ProductList()
        .environment(ProductStore())
        .environment(CartStore())
}
