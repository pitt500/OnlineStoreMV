//
//  RootView.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 07/03/24.
//

import SwiftUI

struct RootView: View {
    @State private var cartStore = CartStore()
    @State private var productStore = ProductStore()
    @State private var accountStore = AccountStore()
    
    var body: some View {
        TabView {
            ProductList()
                .environment(productStore)
                .environment(cartStore)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Products")
                }
            ProfileView()
                .environment(accountStore)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    RootView()
}
