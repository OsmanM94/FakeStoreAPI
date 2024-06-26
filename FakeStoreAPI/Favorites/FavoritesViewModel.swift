//
//  FavoritesViewModel.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 06/06/2024.
//

import Foundation



@Observable
class FavoritesViewModel {
    var favorite = [FavoriteProduct]()
    var cartViewModel: CartViewModel?

    func addToFavorites(product: Product) {
        if let index = favorite.firstIndex(where: { $0.product.id == product.id }) {
            favorite.remove(at: index)
            cartViewModel?.removeFromCart(product: product)
        } else {
            let favoriteProduct = FavoriteProduct(product: product)
            favorite.append(favoriteProduct)
        }
    }
    
    func removeFromFavorites(product: Product) {
        if let index = favorite.firstIndex(where: { $0.product.id == product.id }) {
            favorite.remove(at: index)
            cartViewModel?.removeFromCart(product: product)
        }
    }
    
    func isFavorite(product: Product) -> Bool {
        return favorite.contains(where: { $0.product.id == product.id })
    }
}
