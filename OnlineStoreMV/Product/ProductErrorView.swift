//
//  ProductErrorView.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 01/05/24.
//

import SwiftUI

struct ProductErrorView: View {
    let message: String
    
    var body: some View {
        let _ = print(message)
        VStack {
            Image("errorCloud")
                .resizable()
                .frame(width: 200, height: 200)
            Text("There was a problem reaching the server. Please try again later.")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(20)
                .multilineTextAlignment(.center)
                
        }
        
    }
}

#Preview {
    ProductErrorView(message: "Error")
}
