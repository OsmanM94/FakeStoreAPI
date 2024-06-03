//
//  JumpToTopButton.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 31/05/2024.
//

import SwiftUI

struct JumpToTopButton: View {
    
    let action: () -> Void
  
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Label("Back to top", systemImage: "arrow.up")
                .foregroundStyle(.blue)
                .fontWeight(.semibold)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    JumpToTopButton(action: {})
}
