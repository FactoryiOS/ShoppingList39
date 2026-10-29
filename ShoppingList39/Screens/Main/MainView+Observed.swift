//
//  MainView+Observed.swift
//  ShoppingList39
//
//  Created by Gleb on 21.10.2026.
//

import Foundation
import Observation
import SwiftData

extension MainView {

    @MainActor
    @Observable
    final class Observed {
        var listToDelete: ListItem?
        var isDeletePresented = false
        let error = ErrorState()

        func handleCopy(_ list: ListItem, context: ModelContext) {
            error.handle {
                try ShoppingListStore(context: context).duplicateList(list)
            }
        }

        func handleRequestDelete(_ list: ListItem) {
            listToDelete = list
            isDeletePresented = true
        }

        func handleDelete(context: ModelContext) {
            guard let list = listToDelete else { return }
            defer { listToDelete = nil }
            error.handle {
                try ShoppingListStore(context: context).deleteList(list)
            }
        }
    }
}
