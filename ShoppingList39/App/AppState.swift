//
//  AppState.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 18.10.2026.
//

import SwiftUI

private enum AppStateKeys {
    static let hasSeenWelcome = "hasSeenWelcome"
}

@Observable
final class AppState {
    var hasSeenWelcome: Bool

    init() {
        hasSeenWelcome = UserDefaults.standard.bool(
            forKey: AppStateKeys.hasSeenWelcome
        )
    }

    func completeWelcome() {
        hasSeenWelcome = true
        UserDefaults.standard.set(
            true,
            forKey: AppStateKeys.hasSeenWelcome
        )
    }
}
