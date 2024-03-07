//
//  NumberOfItemsInCartKey.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var productStore: ProductStore {
        get { self[ProductStoreKey.self] }
        set { self[ProductStoreKey.self] = newValue }
    }
}

private struct ProductStoreKey: EnvironmentKey {
    static var defaultValue = ProductStore()
}
