//
//  PageButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 03/06/2024.
//

import SwiftUI

struct LoadMoreButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Load more")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoadMoreButton(action: {})
}
