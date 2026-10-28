//
//  RootView.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 19.10.2026.
//

import SwiftUI

private enum AppStorageKeys {
    static let hasSeenWelcome = "hasSeenWelcome"
}

struct RootView: View {
    @AppStorage(AppStorageKeys.hasSeenWelcome)
    private var hasSeenWelcome = false

    var body: some View {
        if hasSeenWelcome {
            RouterView {
                MainView()
            }
            .transition(.opacity)
        } else {
            WelcomeView {
                withAnimation {
                    hasSeenWelcome = true
                }
            }
            .transition(.opacity)
        }
    }
}
