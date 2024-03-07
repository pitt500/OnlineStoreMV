//
//  ProductList.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct ProductList: View {
    
    @Environment(\.productStore) var productStore
    
    var body: some View {
        NavigationView {
            Group {
//                switch productStore.loadingState {
//                case .loading, .notStarted:
//                    ProgressView()
//                        .frame(width: 100, height: 100)
//                case .error(let message):
//                    Text(message)
//                case .empty:
//                    Text("No Data Found")
//                case .loaded(let products):
//                    List(products) { product in
//                        ProductCell(
//                            product: product,
//                            numberOfItemsInCart: .constant(0)
//                        )
//                    }
//                }
            }
            .task {
                await productStore.fetchProducts()
            }
            .navigationTitle("Products")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        viewStore.send(.setCartView(isPresented: true))
//                    } label: {
//                        Text("Go to Cart")
//                    }
//                }
//            }
//            .sheet(
//                isPresented: viewStore.binding(
//                    get: \.shouldOpenCart,
//                    send: ProductListDomain.Action.setCartView(isPresented:)
//                )
//            ) {
//                IfLetStore(
//                    self.store.scope(
//                        state: \.cartState,
//                        action: ProductListDomain.Action.cart
//                    )
//                ) {
//                    CartListView(store: $0)
//                }
//            }
            
        }
        
    }
}

#Preview {
    ProductList()
}
