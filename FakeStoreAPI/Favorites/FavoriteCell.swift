//
//  FavoriteCell.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 06/06/2024.
//

import SwiftUI

struct FavoriteCell: View {
    
    @Environment(FavoritesViewModel.self) private var favoriteViewModel
    let favoriteProduct: FavoriteProduct
    
    var body: some View {
        HStack(spacing: 0) {
            ImageLoader(url: favoriteProduct.product.image, contentMode: .fit)
                .frame(height: 120)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(favoriteProduct.product.title)
                    .italic()
                Text("\(favoriteProduct.product.price, format: .currency(code: "GBP"))")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    FavoriteCell(favoriteProduct: FavoriteProduct(product: Product.sampleData[0]))
        .environment(FavoritesViewModel())
        .environment(CartViewModel())
}
