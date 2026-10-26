//
//  ShoppingList39App.swift
//  ShoppingList39
//
//  Created by Nikita Tsomuk on 05.10.2026.
//

import SwiftUI
import SwiftData

@main
struct ShoppingList39App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [ListItem.self, ShoppingItem.self])
    }
}
