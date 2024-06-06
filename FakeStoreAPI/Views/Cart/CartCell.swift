//
//  ProductCellSmall.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct CartCell: View {
    
    @Environment(CartViewModel.self) private var cartViewModel
    
    let cartItem: CartItem
  
    var body: some View {
        HStack(spacing: 20) {
            ImageLoader(url: cartItem.product.image, contentMode: .fit)
                .frame(height: 120)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(cartItem.product.title)
                    .italic()
                Text("\(cartItem.product.price, format: .currency(code: "GBP"))")
                    .font(.title3)
                    .fontWeight(.semibold)
                Stepper("Q: \(cartItem.quantity)", value: Binding(
                    get: { cartItem.quantity },
                    set: { newQuantity in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            cartViewModel.updateQuantity(for: cartItem.product, quantity: newQuantity)
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
    CartCell(cartItem: CartItem(product: Product.sampleData[0], quantity: 1))
        .environment(CartViewModel())
}
