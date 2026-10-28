//
//  Route.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 26.10.2026.
//

import Foundation

/// Экраны, на которые переходим через `push`.
enum Route: Hashable {
    case shoppingList(ListItem)
    case listEditor(ListEditorView.Mode)
}

/// Экраны, которые показываются модально через `showModal`.
enum Modal: Identifiable {
    case itemEditor(ShoppingItemEditorView.Mode)

    var id: String {
        switch self {
        case .itemEditor(.create):
            "itemEditor.create"
        case .itemEditor(.edit(let item)):
            "itemEditor.edit.\(item.id)"
        }
    }
}
