//
//  ProductsCacheTests.swift
//  ProductsCacheTests
//
//  Created by Osman M. on 02/06/2024.
//

import XCTest
@testable import FakeStoreAPI

final class ProductsCacheTests: XCTestCase {

    func testSetAndGet() {
        let cache = ProductsCache.shared
        let testKey = "testProductsKey"
        let testProducts = [Product(id: 1994, title: "Tshirt", price: 299, description: "slim fit shirt", category: "random", image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!)]
        
        /// Set products in cache
        cache.set(testProducts, forKey: testKey)
        
        /// Get products from cache
        let cachedProducts = cache.get(forKey: testKey)
        
        XCTAssertNotNil(cachedProducts)
        XCTAssertEqual(cachedProducts?.count, testProducts.count)
        XCTAssertEqual(cachedProducts?.first?.id, testProducts.first?.id)
    }
}
