//
//  MockProductService.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 01/06/2024.
//

import Foundation


class MockDataService: ProductServiceProtocol {
   
    func fetchProducts(page: Int, limit: Int) async throws -> [Product] {
        
        let product = Product(id: 1994, title: "Jacket", price: 299, description: "Jacket to keep you warm in the summer.", category: "", image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!)
        let product2 = Product(id: 1995, title: "Shirt", price: 500, description: "T-shirt to keep you warm in the winter.", category: "", image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!)
        
        return [product, product2]
    }
    
    func createProduct(_ product: Product) async throws -> Product {
        return product
    }
}
