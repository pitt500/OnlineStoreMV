//
//  WithBinding.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 05/03/24.
//

import SwiftUI

struct MutableBindingPreview<StateValue, Content: View>: View {
    @State private var stateValue: StateValue
    let content: (Binding<StateValue>) -> Content

    init(initialValue: StateValue, @ViewBuilder content: @escaping (Binding<StateValue>) -> Content) {
        _stateValue = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($stateValue)
    }
}

