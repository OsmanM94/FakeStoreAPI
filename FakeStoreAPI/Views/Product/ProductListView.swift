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
                            
                            JumpToTopButton(action: { proxy.scrollTo(productVM.products.first) })
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
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 10) {
                        NextPageButton(action: {
                            Task {
                                await productVM.fetchPreviousPage()
                            }
                        }, systemName: "chevron.left")
                        .disabled(productVM.currentPage <= 1)
                        
                        Text("Page \(productVM.currentPage)")
                        
                        NextPageButton(action: {
                            Task {
                                await productVM.fetchNextPage()
                            }
                        }, systemName: "chevron.right")
                        .disabled(!productVM.canLoadMorePages)
                    }
                }
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
            await productVM.fetchProducts(page: 1)
        }
    }
}
#Preview {
    ProductListView()
        .environment(ProductViewModel(service: ProductDataService()))
        .environment(CartViewModel())
}
