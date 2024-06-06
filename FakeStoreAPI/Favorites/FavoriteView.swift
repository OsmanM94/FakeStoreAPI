//
//  SwiftUIView.swift
//  FakeStoreAPI
//
//  Created by asia on 06/06/2024.
//

import SwiftUI

struct FavoriteView: View {
    
    @Environment(FavoritesViewModel.self) private var favoriteViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if !favoriteViewModel.favorite.isEmpty {
                    List {
                        ForEach(favoriteViewModel.favorite, id: \.product.id) { item in
                            FavoriteCell(favoriteProduct: item)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            favoriteViewModel.removeFromFavorites(product: item.product)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                } else {
                    ContentUnavailableView(label: {
                        Label("No products saved", systemImage: "heart.slash.fill")
                    })
                }
            }
            .navigationTitle("Wishlist")
        }
    }
}
    
#Preview {
    FavoriteView()
        .environment(FavoritesViewModel())
}
