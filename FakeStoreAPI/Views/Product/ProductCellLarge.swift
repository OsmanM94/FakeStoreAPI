//
//  ProductCell.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import SwiftUI

struct ProductCellLarge: View {
    
    let product: Product
   
    var body: some View {
        VStack(spacing: 25) {
            AsyncImage(url: product.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
                    .frame(height: 350)
            }
            
            Text(product.title)
                .italic()
                .frame(maxWidth:.infinity, alignment: .leading)
            
            HStack(spacing: 0) {
                Text("\(product.price, format: .currency(code: "GBP"))")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer(minLength: 0)

                AddToCartButton(product: product)
            }
        }
    }
}

#Preview {
    ProductCellLarge(product: Product.sampleData[0])
        .environment(CartViewModel())
}
