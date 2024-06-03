//
//  ProductsCache.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 01/06/2024.
//

import Foundation


class ProductsCache {
    
    static let shared = ProductsCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func set(_ products: [Product], forKey key: String) {
        guard let data = try? JSONEncoder().encode(products) else {
//            print("DEBUG: Failed to encode products for caching")
            return
        }
        cache.setObject(data as NSData, forKey: key as NSString)
//        print("DEBUG: Cached products with key: \(key)")
    }
    
    func get(forKey key: String) -> [Product]? {
        guard let data = cache.object(forKey: key as NSString) as Data? else { 
//            print("DEBUG: No cached data found for key: \(key)")
            return nil
        }
//        print("DEBUG: Successfully retrieved cached products for key: \(key)")
        return try? JSONDecoder().decode([Product].self, from: data)
      
    }
}
