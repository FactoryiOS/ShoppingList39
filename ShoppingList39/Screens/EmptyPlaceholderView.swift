//
//  EmptyPlaceholderView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 10.10.2026.
//

import SwiftUI

struct EmptyStateConfig {
    let imageName: String
    let title: String
    let subtitle: String
    let buttonTitle: String
    
    static let lists = EmptyStateConfig(
        imageName: "notepadWithGlasses",
        title: "Давайте спланируем покупки!",
        subtitle: "Создайте свой первый список",
        buttonTitle: "Создать список"
    )
    
    static let shoppingList = EmptyStateConfig(
        imageName: "shoppingBags",
        title: "Давайте спланируем покупки!",
        subtitle: "Начните добавлять товары",
        buttonTitle: "Добавить товар"
    )
}

struct EmptyStateView: View {
    let config: EmptyStateConfig
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(config.imageName)
            
            Spacer().frame(height: 40)
            
            VStack(spacing: 8) {
                Text(config.title)
                    .font(.title3Semibold)
                    .multilineTextAlignment(.center)
                
                Text(config.subtitle)
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button(action: action) {
                Text(config.buttonTitle)
                    .font(.headlineSemibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.uncategorizedTurquoise)
                    .cornerRadius(24)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
    }
}
#Preview("Списки") {
    EmptyStateView(config: .lists) {
        print("Создать список")
    }
}

#Preview("Список покупок") {
    EmptyStateView(config: .shoppingList) {
        print("Добавить товар")
    }
}
