//
//  RouterView.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 26.10.2026.
//

import SwiftUI

struct RouterView<Root: View>: View {
    @State private var router = Router()

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
            ShoppingListsView(shoppingListsName: list)
        case .listEditor(let mode):
            ListEditorView(mode: mode) { _ in
                // TODO: сохранить список, когда появится слой данных
            }
        }
    }

    @ViewBuilder
    private func modalView(for modal: Modal) -> some View {
        switch modal {
        case .itemEditor(let mode):
            ShoppingItemEditorView(mode: mode) { _ in
                // TODO: сохранить товар, когда появится слой данных
            }
        }
    }
}
