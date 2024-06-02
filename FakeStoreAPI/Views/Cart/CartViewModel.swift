//
//  CartViewModel.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import Foundation

@Observable
final class CartViewModel {
    private(set) var products = [Product]()
    private(set) var total: Double = 0
    private(set) var nextDayPrice: Double = 4.99
    private(set) var vatRate: Double = 0.2
   
    var nextDayService: Bool = false {
        didSet {
           updateTotalForNextDayService()
            
        }
    }

    func addToCart(product: Product) {
        products.append(product)
        total += product.price
        total += product.price * vatRate
    }
    
    func removeFromCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
            total -= product.price
            total -= product.price * vatRate
            
            if nextDayService {
                total = products.reduce(0) { $0 + $1.price } * (1 + vatRate) + nextDayPrice
            }
        }
    }
    
    private func updateTotalForNextDayService() {
        if nextDayService {
            total += nextDayPrice
        } else {
            total -= nextDayPrice
        }
    }
    
}

