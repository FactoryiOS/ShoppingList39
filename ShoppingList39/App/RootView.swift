//
//  RootView.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 19.10.2026.
//

import SwiftUI

struct RootView: View {
    @AppStorage(AppStorageKeys.hasSeenWelcome)
    private var hasSeenWelcome = false

    @AppStorage(AppStorageKeys.appTheme)
    private var themeRawValue = AppTheme.system.rawValue

    var body: some View {
        Group {
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
        .preferredColorScheme(
            (AppTheme(rawValue: themeRawValue) ?? .system).colorScheme
        )
    }
}
