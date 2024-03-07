//
//  CartStoreKey.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 06/03/24.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var cartStore: CartStore {
        get { self[CartStoreKey.self] }
        set { self[CartStoreKey.self] = newValue }
    }
}

private struct CartStoreKey: EnvironmentKey {
    static var defaultValue = CartStore()
}
