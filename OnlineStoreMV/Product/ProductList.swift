//
//  ProductList.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct ProductList: View {
    @Environment(ProductStore.self) private var productStore
    @Environment(CartStore.self) private var cartStore
    @State private var shouldOpenCart = false
    
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
                    ProductErrorView(message: message)
                case .empty:
                    Text("No Products Found")
                case .loaded(let products):
                    List(products) { product in
                        ProductCell(
                            product: product
                        )
                        .environment(cartStore)
                    }
                    .refreshable {
                        await productStore.fetchProducts()
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        shouldOpenCart = true
                    } label: {
                        Text("Go to Cart")
                    }
                }
            }
            .sheet(isPresented: $shouldOpenCart) {
                CartListView()
            }
        }
        
    }
}

#Preview("Happy Path") {
    ProductList()
        .environment(ProductStore(apiClient: .testSuccess))
        .environment(CartStore())
}


#Preview("Empty List") {
    ProductList()
        .environment(ProductStore(apiClient: .testEmpty))
        .environment(CartStore())
}

#Preview("Error from API") {
    ProductList()
        .environment(ProductStore(apiClient: .testError))
        .environment(CartStore())
}
