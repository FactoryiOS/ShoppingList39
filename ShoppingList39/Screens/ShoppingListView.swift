//
//  ShoppingListView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 11.10.2026.
//

import SwiftUI

struct ShoppingListView: View {
    let listName: String
    @State private var items: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                if items.isEmpty {
                    EmptyPlaceholderView(
                        imageName: "shoppingBags",
                        title: "Давайте спланируем покупки!",
                        subtitle: "Начните добавлять товары",
                        buttonTitle: "Добавить товар"
                    ) {
                        addNewItem()
                    }
                } else {
                    List(items, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 6) {
                        Button(action: {
                            // Действие "Назад"
                        }, label: {
                            Image("chevronLeft")
                                .renderingMode(.template)
                                .foregroundColor(.primary)
                        })
                        Text(listName)
                            .font(.title1Semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {
                            // действие "Поиск"
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.primary)
                        })
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.primary)
                        })
                    }
                }
            }
        }
    }
    func addNewItem() {
        print("Добавить товар")
    }
}

#Preview {
    ShoppingListView(listName: "Новый год")
}
