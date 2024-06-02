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
    var errorMessage: String?
    var isLoading: Bool = false
    var searchProduct: String = ""
   
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
    func fetchProducts() async {
        isLoading = true
        do {
            self.products = try await service.fetchProducts()
        } catch {
            guard let error = error as? APIError else { return }
            self.errorMessage = error.customDescription
        }
        isLoading = false
    }
}
