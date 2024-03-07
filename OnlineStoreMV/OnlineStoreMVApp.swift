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
    
    var body: some Scene {
        WindowGroup {
            ProductCell(product: Product.sample.first!)
                .environment(cartStore)
        }
    }
}
