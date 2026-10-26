//
//  ShoppingListsView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 21.10.2026.
//

import SwiftUI

struct ShoppingListsView: View {
    let shoppingListsName: ListItem

@State private var observed = ShoppingListsViewObserved()
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(observed.filteredItems) { item in
                    ShoppingItemCell(item: item) {
                        observed.togglePurchase(for: item)
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
                            observed.deleteItem(item)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                        
                        Button {
                            observed.editItem(item)
                        } label: {
                            Label("Изменить", systemImage: "square.and.pencil")
                        }
                        .tint(.systemsLightGrey)
                    }
                }
            }
            .listStyle(.plain)
            .listRowSpacing(12)
            
            BaseButton(title: "Добавить товар") {
                // TODO: Добавить реализацию добавления товара
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $observed.searchText, prompt: "Поиск")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 6) {
                    Text(shoppingListsName.name)
                        .font(.headlineSemibold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: Добавить действие меню
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview("Светлая тема")  {
    NavigationStack {
        ShoppingListsView(shoppingListsName: .mock)
    }
    .preferredColorScheme(.light)
}
#Preview("Темная тема")  {
    NavigationStack {
        ShoppingListsView(shoppingListsName: .mock)
    }
    .preferredColorScheme(.dark)
}
