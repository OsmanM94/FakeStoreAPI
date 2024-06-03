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
    private(set) var isLoading: Bool = false
    var searchProduct: String = ""
    
    private(set) var currentPage: Int = 1
    private(set) var pageSize: Int = 2
    private(set) var canLoadMorePages: Bool = true
    
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
    func fetchProducts(page: Int) async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let newProducts = try await service.fetchProducts(page: page, limit: pageSize)
            products.append(contentsOf: newProducts)
            canLoadMorePages = !newProducts.isEmpty
            currentPage = page
        } catch {
            guard let error = error as? APIError else { return }
            self.errorMessage = error.customDescription
        }
        isLoading = false
    }
    
    func loadMore() async {
        await fetchProducts(page: currentPage + 1)
    }
    
    @MainActor
    func refreshData() async {
        currentPage = 1
        canLoadMorePages = true
        products.removeAll()
        await fetchProducts(page: 1)
    }
}


