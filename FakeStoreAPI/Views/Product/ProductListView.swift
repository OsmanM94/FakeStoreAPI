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
                                ProductCell(product: product)
                                    .id(product)
                            }
                            LoadMoreButton(action: {
                                Task {
                                    await productVM.loadMore()
                                }
                            }, isLoading: Bindable(productVM).isLoading)
                            .disabled(!productVM.canLoadMorePages || productVM.isLoading)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .refreshable {
                            await productVM.refreshData()
                        }
                        .overlay {
                            if productVM.isLoading {
                                ProgressView()
                                    .scaleEffect(1.5)
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
                            .scaleEffect(1.5)
                    }
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                       isActive = true
                    }
                }
            }
            .buttonStyle(.plain)
            .navigationTitle("Products")
            .searchable(text: Bindable(productVM).searchProduct, placement: .navigationBarDrawer(displayMode: .always))
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
        .environment(FavoritesViewModel())
}

