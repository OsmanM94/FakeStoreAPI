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
                            HStack(spacing: 10) {
                                JumpToTopButton(action: { proxy.scrollTo(productVM.products.first) })
                                Text("or")
                                LoadMore(action: {
                                    Task {
                                        await productVM.loadMore()
                                    }
                                })
                                .disabled(!productVM.canLoadMorePages)
                            }
                           
                        }
                        .refreshable {
                            await productVM.fetchProducts(page: 1)
                        }
                        .overlay(alignment: .center) {
                            if productVM.isLoading {
                                ProgressView()
                            }
                        }
                    } else {
                       ProgressView()
                           .transition(.opacity)
                   }
                }
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
            await productVM.refreshData()
        }
    }
}
#Preview {
    ProductListView()
        .environment(ProductViewModel(service: ProductDataService()))
        .environment(CartViewModel())
}
