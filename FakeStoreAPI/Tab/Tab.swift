//
//  Tab.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct Tab: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }
                .tag(0)
            
            FavoriteView()
                .tabItem {
                    Label("Wishlist", systemImage: "heart.fill")
                }
                .tag(1)
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(2)
            
        }
    }
}

#Preview {
    Tab()
        .environment(ProductViewModel(service: MockDataService()))
        .environment(CartViewModel())
        .environment(FavoritesViewModel())
}
