//
//  CartListView.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct CartView: View {
    
    @Environment(CartViewModel.self) private var cartViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.cartItems.count > 0 {
                    List {
                        ForEach(cartViewModel.cartItems, id: \.product.id) { item in
                            CartCell(cartItem: item)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            cartViewModel.removeFromCart(product: item.product)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                        .listRowSeparator(.hidden, edges: .all)
                        
                        VStack(spacing: 0) {
                            Toggle("Next day service?", isOn: Bindable(cartViewModel).nextDayService.animation())
                        }
                        
                        if cartViewModel.nextDayService {
                            HStack(spacing: 0) {
                                Text("DPD Next day")
                                Spacer(minLength: 0)
                                Text("\(cartViewModel.nextDayPrice, format: .currency(code: "GBP"))")
                            }
                        }
                        HStack(spacing: 0) {
                            Text("VAT")
                            Spacer(minLength: 0)
                            Text("20%")
                        }
                        HStack(spacing: 0) {
                            Text("Total")
                            Spacer(minLength: 0)
                            Text("\(cartViewModel.total, format: .currency(code: "GBP"))")
                                .fontWeight(.semibold)
                        }
                    }
                    .listStyle(.plain)
                    
                    VStack(spacing: 0) {
                        Button(action: {}) {
                            Text("Proceed to Payment")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .padding([.horizontal, .bottom])
                    
                } else {
                    ContentUnavailableView(label: {
                        Label("No products added", systemImage: "tray.fill")
                    }, description: {
                        Text("Start adding products today.")
                    })
                }
            }
            .navigationTitle("My products")
        }
    }
}

#Preview {
    CartView()
        .environment(CartViewModel())
}


