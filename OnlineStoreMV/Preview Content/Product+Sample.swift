//
//  Product+Sample.swift
//  OnlineStoreMV
//
//  Created by Pedro Rojas on 04/05/24.
//

import Foundation

extension Product {
    static var sample: [Product] {
        [
            Product(
                id: 1,
                title: "T-shirt",
                price: 20,
                description: "This is a description of a cool T-shirt",
                category: "SomeArticle",
                imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!,
                percentageDiscount: 0.1
            ),
            Product(
                id: 2,
                title: "T-shirt",
                price: 20,
                description: "This is a description of a cool T-shirt",
                category: "SomeArticle",
                imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!
            ),
            Product(
                id: 3,
                title: "T-shirt",
                price: 20,
                description: "This is a description of a cool T-shirt",
                category: "SomeArticle",
                imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!
            ),
        ]
    }
    
    static var uiTestSample: [Product] {
        [
            Product(
                id: 1,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 20,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: "men's clothing",
                imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!,
                percentageDiscount: 0.1
            ),
            Product(
                id: 2,
                title: "Mens Casual Premium Slim Fit T-Shirts",
                price: 20,
                description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                category: "men's clothing",
                imageURL: URL(string: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg")!
            ),
            Product(
                id: 3,
                title: "Mens Cotton Jacket",
                price: 20,
                description: "Great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
                category: "men's clothing",
                imageURL: URL(string: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg")!
            ),
            Product(
                id: 4,
                title: "Mens Casual Slim Fit",
                price: 20,
                description: "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
                category: "men's clothing",
                imageURL: URL(string: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg")!
            ),
            Product(
                id: 5,
                title: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
                price: 20,
                description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
                category: "jewelery",
                imageURL: URL(string: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg")!
            ),
            Product(
                id: 6,
                title: "Solid Gold Petite Micropave ",
                price: 20,
                description: "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
                category: "jewelery",
                imageURL: URL(string: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg")!
            ),
        ]
    }
}
