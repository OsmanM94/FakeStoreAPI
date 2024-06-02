//
//  ProductDataService.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 01/06/2024.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
    func createProduct(_ product: Product) async throws -> Product
}


class ProductDataService: ProductServiceProtocol, HTTPDataDownloader {
    
    init() { }

     private let endPoint = "https://fakestoreapi.com/products"
     private let cacheKey = "productsCacheKey"
    
    func fetchProducts() async throws -> [Product] {
        if let cachedProducts = ProductsCache.shared.get(forKey: cacheKey) {
            print("DEBUG: Got data from cache")
            return cachedProducts
        }
        let products = try await fetchData(as: [Product].self, endpoint: endPoint)
        print("DEBUG: Got data from API.")
        
        ProductsCache.shared.set(products, forKey: cacheKey)
        
        return products
    }
    
    func createProduct(_ product: Product) async throws -> Product {
        let newProduct = try await postData(as: Product.self, to: endPoint, body: product)

        ProductsCache.shared.set([newProduct], forKey: cacheKey)

        return newProduct
    }
}


