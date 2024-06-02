//
//  CategoryView.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import SwiftUI

struct ProductListView: View {
    
    @Environment(ProductViewModel.self) private var productVM
    @Environment(CartViewModel.self) private var cartVM
    
    var body: some View {
        NavigationStack {
            if productVM.products.isEmpty {
                ProgressView()
            } else {
                ScrollViewReader { proxy in
                    List {
                        ForEach(productVM.filteredProducts, id: \.id) { product in
                            ProductCellLarge(product: product)
                                .id(product)
                                .onAppear {
                                    if product == productVM.products.last {
                                        print("DEBUG: Paginate here...")
                                    }
                                }
                        }
                        JumpToTopButton(action: { proxy.scrollTo(productVM.products.first) })
                    }
                    .navigationTitle("Products")
                    .searchable(text: Bindable(productVM).searchProduct)
                    .refreshable {
                        await productVM.fetchProducts()
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            NavigationLink {
                                CartView()
                            } label: {
                                CartNavigation(numberOfProducts: cartVM.products.count)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .task {
            await productVM.fetchProducts()
        }
    }
}

#Preview {
    ProductListView()
        .environment(ProductViewModel(service: ProductDataService()))
        .environment(CartViewModel())
}
