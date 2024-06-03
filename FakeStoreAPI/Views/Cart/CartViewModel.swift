//
//  CartViewModel.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import Foundation


@Observable
final class CartViewModel {
    private(set) var cartItems = [CartItem]()
    private(set) var total: Double = 0
    private(set) var nextDayPrice: Double = 4.99
    private(set) var vatRate: Double = 0.2
    var quantity: Int = 1
    
    var nextDayService: Bool = false {
        didSet {
            updateTotalForNextDayService()
        }
    }
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(product: product, quantity: 1)
            cartItems.append(newItem)
        }
        updateTotal()
    }
    
    func removeFromCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems.remove(at: index)
        }
        updateTotal()
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity = quantity
            updateTotal()
        }
    }
    
    private func updateTotal() {
        total = cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        total += total * vatRate
        if nextDayService {
            total += nextDayPrice
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

