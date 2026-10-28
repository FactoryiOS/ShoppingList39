//
//  ShoppingListsView+Observed.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 24.10.2026.
//
import SwiftUI
import Observation

@Observable
class ShoppingListsViewObserved {
    
    var items: [ShoppingItem] = [
        ShoppingItem.mock,
        ShoppingItem.mock,
        ShoppingItem.mock
    ]
    
    var searchText = ""
    
    var filteredItems: [ShoppingItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func togglePurchase(for item: ShoppingItem) {
        withAnimation {
            item.isPurchased.toggle()
        }
    }
    
    func deleteItem(_ item: ShoppingItem) {
        // TODO: Добавить действие  удаления
        print("Удален товар: \(item.name)")
    }
}

