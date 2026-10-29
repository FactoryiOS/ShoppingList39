//
//  RouterView.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 26.10.2026.
//

import SwiftUI
import SwiftData

struct RouterView<Root: View>: View {
    @State private var router = Router()
    @Environment(\.modelContext) private var modelContext

    private let root: Root

    init(@ViewBuilder root: () -> Root) {
        self.root = root()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            root
                .navigationDestination(for: Route.self) { route in
                    destination(for: route)
                }
        }
        .sheet(item: $router.modal) { modal in
            modalView(for: modal)
        }
        .environment(router)
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .shoppingList(let list):
            ShoppingListsView(list: list)
        case .listEditor(let mode):
            ListEditorView(mode: mode) { values in
                let store = ShoppingListStore(context: modelContext)
                switch mode {
                case .create:
                    try store.createList(name: values.name, icon: values.icon, color: values.color)
                case .edit(let list):
                    try store.updateList(list, name: values.name, icon: values.icon, color: values.color)
                }
            }
        }
    }

    @ViewBuilder
    private func modalView(for modal: Modal) -> some View {
        switch modal {
        case .itemEditor(let mode, let list):
            ShoppingItemEditorView(mode: mode) { values in
                let store = ShoppingListStore(context: modelContext)
                switch mode {
                case .create:
                    try store.addItem(to: list, name: values.name, quantity: values.quantity, unit: values.unit)
                case .edit(let item):
                    try store.updateItem(item, name: values.name, quantity: values.quantity, unit: values.unit)
                }
            }
        }
    }
}
