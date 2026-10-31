//
//  EmptyStateView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 10.10.2026.
//

import SwiftUI

struct EmptyStateConfig {
    let imageName: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    
    static let lists = EmptyStateConfig(
        imageName: "notepadWithGlasses",
        title: "Давайте спланируем покупки!",
        subtitle: "Создайте свой первый список"
    )
    
    static let shoppingList = EmptyStateConfig(
        imageName: "shoppingBags",
        title: "Давайте спланируем покупки!",
        subtitle: "Начните добавлять товары"
    )
}

struct EmptyStateView: View {
    let config: EmptyStateConfig
    
    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            
            Image(config.imageName)
            
            VStack(spacing: 4) {
                Text(config.title)
                    .font(.title3Semibold)
                    .multilineTextAlignment(.center)
                
                Text(config.subtitle)
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}
#Preview("Списки") {
    EmptyStateView(config: .lists)
}

#Preview("Список покупок") {
    EmptyStateView(config: .shoppingList)
}
