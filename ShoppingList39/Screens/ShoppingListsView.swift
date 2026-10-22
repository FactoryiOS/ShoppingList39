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
    
    @State private var searchText = ""
    var filteredItems: [ShoppingItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(filteredItems) { item in
                    ShoppingItemCell(item: item) {
                        togglePurchase(for: item)
                    }
                    .listRowSeparator(.hidden)
                    
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.greyStrokePanelIOS)
                            .frame(height: 1)
                            .padding(.leading, 0)
                    }
                    
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            deleteItem(item)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                        
                        Button {
                            editItem(item)
                        } label: {
                            Label("Изменить", systemImage: "square.and.pencil")
                        }
                        .tint(.systemsLightGrey)
                    }
                }
            }
            .listStyle(.plain)
            
            BaseButton(title: "Добавить товар") {
                print("Добавить товар")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Поиск")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text(shoppingListsName)
                        .font(.headlineSemibold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20, weight: .regular))
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
    
    private func deleteItem(_ item: ShoppingItem) {
        print("Удален товар: \(item.name)")
    }
    
    private func editItem(_ item: ShoppingItem) {
        print("Редактирование товара: \(item.name)")
    }
}

#Preview {
    NavigationStack {
        ShoppingListsView(shoppingListsName: "Новый год")
    }
}
