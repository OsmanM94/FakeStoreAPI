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
//            print("DEBUG: Fetching products for page \(page)")
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
    
    @MainActor
    func refreshData() async {
           isLoading = true
           products = []
           currentPage = 1
           canLoadMorePages = true
           await fetchProducts(page: 1) 
           isLoading = false
       }
    
    @MainActor
    func fetchNextPage() async {
        await fetchProducts(page: currentPage + 1)
    }
    
    @MainActor
    func fetchPreviousPage() async {
        guard currentPage > 1 else { return }
        await fetchProducts(page: currentPage - 1)
    }
    
//    @MainActor
//    func testFetchProducts() async {
//        print("DEBUG: Fetching products for the first time...")
//        await fetchProducts(page: 1)
//        
//        currentPage = 1
//        
//        print("DEBUG: Fetching products again to test cache...")
//        await fetchProducts(page: 1)
//    }

}


