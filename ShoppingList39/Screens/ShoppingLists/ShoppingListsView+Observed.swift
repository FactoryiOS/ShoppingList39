//
//  ShoppingListsView+Observed.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 24.10.2026.
//
import SwiftUI
import Observation
import SwiftData

extension ShoppingListsView {
    @MainActor
    @Observable
    final class Observed {
        let list: ListItem
        var searchText = ""
        var isSortedByName = false
        var itemToDelete: ShoppingItem?
        var isDeletePresented = false
        var isDeletePurchasedPresented = false
        let error = ErrorState()

        init(list: ListItem) {
            self.list = list
        }

        var filteredItems: [ShoppingItem] {
            let items = isSortedByName ? itemsSortedByName : list.sortedItems
            if searchText.isEmpty {
                return items
            } else {
                return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }

        /// Текст списка для «Поделиться»: название и товары с отметкой о покупке.
        var shareText: String {
            let lines = list.sortedItems.map { item in
                let mark = item.isPurchased ? "✓" : "•"
                return "\(mark) \(item.name) — \(item.quantity.formatted()) \(item.unit.title)"
            }
            return ([list.name] + lines).joined(separator: "\n")
        }

        private var itemsSortedByName: [ShoppingItem] {
            list.sortedItems.sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
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

        func handleUncheckAll(context: ModelContext) {
            error.handle {
                try ShoppingListStore(context: context).uncheckAllItems(in: list)
            }
        }

        func handleDeletePurchased(context: ModelContext) {
            error.handle {
                try ShoppingListStore(context: context).deletePurchasedItems(from: list)
            }
        }
    }
}
