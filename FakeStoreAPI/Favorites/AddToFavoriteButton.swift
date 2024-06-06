//
//  AddToFavoriteButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 06/06/2024.
//

import SwiftUI

struct AddToFavoriteButton: View {
    
    @Environment(FavoritesViewModel.self) private var favoriteViewModel
    let product: Product
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Button(action: {
                favoriteViewModel.addToFavorites(product: product)
            }, label: {
                Image(systemName: favoriteViewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                    .padding(.horizontal)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.bounce, value: favoriteViewModel.isFavorite(product: product))
            })
            .offset(x: 20)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: favoriteViewModel.isFavorite(product: product))
    }
}

#Preview {
    AddToFavoriteButton(product: Product.sampleData[0])
        .environment(FavoritesViewModel())
}
