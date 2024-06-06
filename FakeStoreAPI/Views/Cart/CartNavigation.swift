//
//  CartButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct CartNavigation: View {
    
    @State private var animateSymbol: Bool = false
    let numberOfProducts: Int
   
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
                .symbolEffect(.bounce, value: animateSymbol)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption).bold()
                    .foregroundStyle(.white)
                    .frame(width: 15, height: 15)
                    .background(.red.gradient, in: RoundedRectangle(cornerRadius: 25))
                    .sensoryFeedback(.impact(flexibility: .soft), trigger: numberOfProducts)
            }
        }
        .onAppear {
            animateSymbol.toggle()
        }
    }
}

#Preview {
    CartNavigation(numberOfProducts: 1)
}
