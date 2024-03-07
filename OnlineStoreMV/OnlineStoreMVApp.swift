//
//  OnlineStoreMVApp.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 04/03/24.
//

import SwiftUI

@main
struct OnlineStoreMVApp: App {
    @State var cartStore = CartStore()
    @State var productStore = ProductStore()
    
    var body: some Scene {
        WindowGroup {
            ProductList()
                .environment(productStore)
                .environment(cartStore)
        }
    }
}
