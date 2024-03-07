//
//  ProductList.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct ProductList: View {
    @Environment(ProductStore.self) var productStore
    @Environment(CartStore.self) var cartStore
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

#Preview {
    ProductList()
        .environment(ProductStore(apiClient: .test))
        .environment(CartStore())
}
