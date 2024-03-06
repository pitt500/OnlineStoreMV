//
//  NumberOfItemsInCartKey.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var numberOfItemsInCart: Int {
        get { self[NumberOfItemsInCartKey.self] }
        set { self[NumberOfItemsInCartKey.self] = newValue }
    }
}

private struct NumberOfItemsInCartKey: EnvironmentKey {
    static var defaultValue = 0
}

extension View {
    func numberOfItems(_ value: Int) -> some View {
        environment(\.numberOfItemsInCart, value)
    }
}
