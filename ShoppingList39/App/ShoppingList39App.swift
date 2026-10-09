//
//  ShoppingList39App.swift
//  ShoppingList39
//
//  Created by Nikita Tsomuk on 05.10.2026.
//

import SwiftUI

@main
struct ShoppingList39App: App {
    @State private var isShowingLaunch = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()

                if isShowingLaunch {
                    LaunchScreenView()
                        .transition(.opacity)
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(LaunchConstants.displayDuration))
                withAnimation(.easeOut(duration: LaunchConstants.fadeDuration)) {
                    isShowingLaunch = false
                }
            }
        }
    }
}

private enum LaunchConstants {
    static let displayDuration: Double = 1.5
    static let fadeDuration: Double = 0.5
}
