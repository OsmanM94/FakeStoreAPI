//
//  CategoryViewModel.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import Foundation


@Observable
final class ProductViewModel {
    private(set) var products = [Product]()
    private(set) var errorMessage: String?
    var isLoading: Bool = false
    var searchProduct: String = ""
    var isFavorite: Bool = false
    
    private(set) var currentPage: Int = 1
    private(set) var pageSize: Int = 10
    private(set) var canLoadMorePages: Bool = true
    private var lastRefreshTime: Date? = nil
    private let refreshCooldown: TimeInterval = 30
   
    var filteredProducts: [Product] {
        guard !searchProduct.isEmpty else { return products }
        return products.filter { product in
            product.title.lowercased().contains(searchProduct.lowercased())
        }
    }
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchProducts(page: Int, useCache: Bool = true) async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let newProducts = try await service.fetchProducts(page: page, limit: pageSize, useCache: useCache)
            
            let newUniqueProducts = newProducts.filter { newProduct in
                !products.contains(where: { $0.id == newProduct.id })
            }
            products.append(contentsOf: newUniqueProducts)
            
            if products.count >= 20  {
                canLoadMorePages = false
            } else {
                canLoadMorePages = true
            }
            
            currentPage = page
            
        } catch {
            guard let error = error as? APIError else { return }
            self.errorMessage = error.customDescription
        }
        isLoading = false
    }
    
    @MainActor
    func loadMore() async {
        pageSize += 10
        await fetchProducts(page: currentPage + 1)
    }
    
    @MainActor
    func refreshData() async {
        if let lastRefreshTime = lastRefreshTime {
            let timeSinceLastRefresh = Date().timeIntervalSince(lastRefreshTime)
            if timeSinceLastRefresh < refreshCooldown {
                return
            }
        }
        currentPage = 1
        canLoadMorePages = true
        pageSize = 10
        products.removeAll()
        await fetchProducts(page: currentPage + 1, useCache: false)
        
        lastRefreshTime = Date()
    }
    
}
