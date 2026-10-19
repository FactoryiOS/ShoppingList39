//
//  RootView.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 19.10.2026.
//

import SwiftUI

struct RootView: View {
    @State private var appState = AppState()

    var body: some View {
        if appState.hasSeenWelcome {
            ContentView()
        } else {
            WelcomeView {
                appState.completeWelcome()
            }
        }
    }
}
