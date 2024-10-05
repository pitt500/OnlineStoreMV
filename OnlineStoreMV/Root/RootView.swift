//
//  RootView.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 07/03/24.
//

import SwiftUI

struct RootView: View {
    @State private var cartStore = CartStore(
        apiClient: apiClient(),
        logger: .fileLogging()
    )
    @State private var productStore = ProductStore(
        apiClient: apiClient(),
        discountCalculator: .init(discountProvider: .live),
        logger: .fileLogging()
    )
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

extension RootView {
    private static var isUITestRunning: Bool {
        ProcessInfo.processInfo.environment["UI_Testing_Enabled"] == "YES"
    }
    
    private static func apiClient() -> APIClient {
        isUITestRunning ? .uiTestSuccess : .live
    }
}
