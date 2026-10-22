//
//  ShoppingListsView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 21.10.2026.
//

import SwiftUI

struct ShoppingListsView: View {
    let shoppingListsName: String
    
    @State private var items: [ShoppingItem] = [
        ShoppingItem.mock,
        ShoppingItem.mock,
        ShoppingItem.mock
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(items) { item in
                    ShoppingItemCell(item: item) {
                        togglePurchase(for: item)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .listStyle(.plain)
            
            BaseButton(title: "Добавить товар") {
                print("Добавить товар")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .navigationTitle(shoppingListsName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
    }
    private func togglePurchase(for item: ShoppingItem) {
        item.isPurchased.toggle()
        withAnimation {
            items = items
        }
    }
}

#Preview {
    NavigationStack {
        ShoppingListsView(shoppingListsName: "Новый год")
    }
}
