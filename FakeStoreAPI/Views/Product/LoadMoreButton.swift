//
//  PageButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 03/06/2024.
//

import SwiftUI

struct LoadMoreButton: View {
    
    let action: () -> Void
    @Binding var isLoading: Bool
    
    var body: some View {
        Button(action: {
            action()
        }) {
            if isLoading {
                ProgressView()
                    .scaleEffect(1)
            } else {
                Text("Load more")
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoadMoreButton(action: {}, isLoading: .constant(false))
}
