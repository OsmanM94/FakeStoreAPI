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
            Label("Load more", systemImage: "arrow.clockwise")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoadMore(action: {})
}
