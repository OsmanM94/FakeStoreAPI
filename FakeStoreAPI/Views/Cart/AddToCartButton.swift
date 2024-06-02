//
//  AddToCartButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct AddToCartButton: View {
    
    @Environment(CartViewModel.self) private var cartViewModel
    let product: Product
    
    var body: some View {
        Button {
            cartViewModel.addToCart(product: product)
        } label: {
            Text("Add to cart")
                .fontWeight(.semibold)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
    }
}

#Preview {
    AddToCartButton(product: Product.sampleData[0])
        .environment(CartViewModel())
}
