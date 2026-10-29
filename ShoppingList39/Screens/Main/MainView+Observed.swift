//
//  MainView+Observed.swift
//  ShoppingList39
//
//  Created by Gleb on 21.10.2026.
//

import Foundation
import Observation

extension MainView {

    @MainActor
    @Observable
    final class Observed {
        var lists: [ListItem]

        var isEmpty: Bool {
            lists.isEmpty
        }

        init(lists: [ListItem] = []) {
            self.lists = lists
        }

        func handleCopy(_ list: ListItem) {
            print("Копировать: \(list.name)")
        }

        func handleDelete(_ list: ListItem) {
            print("Удалить: \(list.name)")
        }
    }
}
