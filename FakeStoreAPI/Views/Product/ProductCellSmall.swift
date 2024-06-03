//
//  ProductCellSmall.swift
//  FakeStoreAPI
//
//  Created by asia on 31/05/2024.
//

import SwiftUI

struct ProductCellSmall: View {
    
    @Environment(CartViewModel.self) private var cartViewModel
    
    let product: CartItem

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: product.product.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
            } placeholder: {
                ProgressView()
                    .frame(height: 150)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.product.title)
                    .italic()
                Text("\(product.product.price, format: .currency(code: "GBP"))")
                    .font(.title3)
                    .fontWeight(.semibold)
                Stepper("Q: \(product.quantity)", value: Binding(
                    get: { product.quantity },
                    set: { newQuantity in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            cartViewModel.updateQuantity(for: product.product, quantity: newQuantity)
                        }
                    }
                ), in: 1...10)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProductCellSmall(product: CartItem(product: Product.sampleData[0], quantity: 1))
        .environment(CartViewModel())
}
