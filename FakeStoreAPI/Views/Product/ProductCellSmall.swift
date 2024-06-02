//
//  ProductCellSmall.swift
//  FakeStoreAPI
//
//  Created by asia on 31/05/2024.
//

import SwiftUI

struct ProductCellSmall: View {
    
    let product: Product
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: product.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
            } placeholder: {
                ProgressView()
                    .frame(height: 150)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.title)
                    .italic()
                Text("\(product.price, format: .currency(code: "GBP"))")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProductCellSmall(product: Product.sampleData[0])
}
