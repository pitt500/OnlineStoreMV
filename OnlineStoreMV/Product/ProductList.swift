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
                    ContentUnavailableView(
                        "There was a problem reaching the server. Please try again later.",
                        image: "errorCloud",
                        description: Text(message)
                    )
                case .empty:
                    ContentUnavailableView {
                        Label{
                            Text("No Products Found")
                        } icon: { 
                            Image("question")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    } description : {
                        Text("More products will come soon")
                    } actions: {
                        Button {
                            Task {
                                await productStore.fetchProducts()
                            }
                        } label: {
                            Text("Retry")
                                .font(.title)
                        }
                    }
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

#if DEBUG
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
#endif
