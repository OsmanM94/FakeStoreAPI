//
//  Store.swift
//  FakeStoreAPI
//
//  Created by asia on 30/05/2024.
//

import Foundation

struct Product: Identifiable, Codable, Hashable, Equatable {
    var id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
}

extension Product {
    static var sampleData: [Product] {
        [
            Product(
                id: 1,
                title: "Buy a T-shirt",
                price: 80, 
                description: "this is a description",
                category: "category",
                image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!
            )
        ]
    }
}



