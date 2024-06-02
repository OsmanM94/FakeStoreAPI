//
//  Tab.swift
//  FakeStoreAPI
//
//  Created by asia on 31/05/2024.
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
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "gearshape.fill")
                }
                .tag(1)
        }
    }
}

#Preview {
    Tab()
        .environment(ProductViewModel(service: MockDataService()))
        .environment(CartViewModel())
}
