//
//  FakeStoreAPIApp.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import SwiftUI

@main
struct FakeStoreAPIApp: App {
    
    @State private var productViewModel = ProductViewModel(service: ProductDataService())
    @State private var cartViewModel = CartViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            Tab()
                .environment(productViewModel)
                .environment(cartViewModel)
                .environment(favoritesViewModel)
        }
    }  
}


