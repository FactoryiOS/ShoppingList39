//
//  ShoppingListsView+Observed.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 24.10.2026.
//
import SwiftUI
import Observation
import SwiftData

@MainActor
@Observable
final class ShoppingListsViewObserved {
    let list: ListItem
    var searchText = ""
    var itemToDelete: ShoppingItem?
    var isDeletePresented = false
    var isDeletePurchasedPresented = false
    let error = ErrorState()

    init(list: ListItem) {
        self.list = list
    }

    var filteredItems: [ShoppingItem] {
        let items = list.sortedItems
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func togglePurchase(for item: ShoppingItem, context: ModelContext) {
        withAnimation {
            _ = error.handle {
                try ShoppingListStore(context: context).togglePurchased(item)
            }
        }
    }

    func handleRequestDelete(_ item: ShoppingItem) {
        itemToDelete = item
        isDeletePresented = true
    }

    func handleDelete(context: ModelContext) {
        guard let item = itemToDelete else { return }
        defer { itemToDelete = nil }
        error.handle {
            try ShoppingListStore(context: context).deleteItem(item)
        }
    }

    func handleDeletePurchased(context: ModelContext) {
        error.handle {
            try ShoppingListStore(context: context).deletePurchasedItems(from: list)
        }
    }
}
