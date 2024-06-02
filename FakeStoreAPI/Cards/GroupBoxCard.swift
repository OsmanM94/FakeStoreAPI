//
//  GroupBoxCard.swift
//  FakeStoreAPI
//
//  Created by asia on 30/05/2024.
//

import SwiftUI


struct GroupBoxCard: View {
    
    var body: some View {
        
        GroupBox("Title") {
            Text("This is a long description")
        }
        .padding(.horizontal)
        .groupBoxStyle(.cardBoxStyle)
    }
}

struct GroupStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .font(.title3)
                .padding(.bottom, 5)
            configuration.content
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

extension GroupBoxStyle where Self == GroupStyle {
    static var cardBoxStyle: GroupStyle { .init() }
}


#Preview {
    GroupBoxCard()
}
