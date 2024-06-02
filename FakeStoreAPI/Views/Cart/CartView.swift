//
//  CartListView.swift
//  FakeStoreAPI
//
//  Created by asia on 31/05/2024.
//

import SwiftUI

struct CartView: View {
    
    @Environment(CartViewModel.self) private var cartViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.products.count > 0 {
                    List {
                        ForEach(cartViewModel.products, id: \.id) { product in
                            ProductCellSmall(product: product)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            cartViewModel.removeFromCart(product: product)
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
                    
                } else {
                    ContentUnavailableView(label: {
                        Label("No products added", systemImage: "tray.fill")
                    }, description: {
                        Text("Start adding products today.")
                    }, actions: {
                        NavigationLink {
                            ProductListView()
                        } label: {
                            Text("Shop")
                        }
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