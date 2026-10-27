//
//  Router.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 26.10.2026.
//

import Observation

/// Навигация приложения: стек экранов и модальное окно.
///
/// Использование в любом экране внутри `RouterView`:
/// ```swift
/// @Environment(Router.self) private var router
///
/// router.push(.shoppingList(list))
/// router.showModal(.itemEditor(.create))
/// ```
@MainActor
@Observable
final class Router {
    var path: [Route] = []
    var modal: Modal?

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func showModal(_ modal: Modal) {
        self.modal = modal
    }

    func dismissModal() {
        modal = nil
    }
}
