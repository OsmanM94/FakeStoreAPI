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
    
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                ScrollViewReader { proxy in
                    if isActive {
                        List {
                            ForEach(productVM.filteredProducts, id: \.id) { product in
                                ProductCellLarge(product: product)
                                    .id(product)
                            }
                            LoadMoreButton(action: {
                                Task {
                                    await productVM.loadMore()
                                }
                            })
                            .disabled(!productVM.canLoadMorePages)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .refreshable {
                            await productVM.refreshData()
                        }
                        .overlay(alignment: .center) {
                            if productVM.isLoading {
                                ProgressView()
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                NavigationLink {
                                    CartView()
                                } label: {
                                    CartNavigation(numberOfProducts: cartVM.cartItems.count)
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                JumpToTopButton(action: { proxy.scrollTo(productVM.products.first) })
                            }
                        }
                    }
                    else {
                        ProgressView()
                            .transition(.opacity)
                    }
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isActive = true
                    }
                }
            }
            .onDisappear {
                isActive = false
            }
            .buttonStyle(.plain)
            .navigationTitle("Products")
            .searchable(text: Bindable(productVM).searchProduct)
        }
        .task {
            await productVM.fetchProducts(page: productVM.currentPage)
        }
    }
}
#Preview {
    ProductListView()
        .environment(ProductViewModel(service: ProductDataService()))
        .environment(CartViewModel())
}
