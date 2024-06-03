//
//  PageButton.swift
//  FakeStoreAPI
//
//  Created by asia on 03/06/2024.
//

import SwiftUI

struct LoadMore: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Load More")
                .fontWeight(.semibold)
            
        }
    }
}

#Preview {
    LoadMore(action: {})
}
