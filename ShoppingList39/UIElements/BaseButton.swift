//
//  BaseButton.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 11.10.2026.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    var isActive = true
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headlineSemibold)
                .foregroundStyle(isActive ? Color.uncategorizedWhite : Color.greyHint)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(isActive ? Color.uncategorizedTurquoise : .greyButton, in: Capsule())
        }
        .buttonStyle(BaseButtonStyle())
        .disabled(!isActive)
        .animation(.easeInOut(duration: 0.2), value: isActive)
    }
}

private struct BaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

// MARK: - Preview

#Preview("Light") {
    VStack(spacing: 16) {
        BaseButton(title: "Создать", isActive: true) {}
        BaseButton(title: "Создать", isActive: false) {}
    }
    .padding()
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 16) {
        BaseButton(title: "Создать", isActive: true) {}
        BaseButton(title: "Создать", isActive: false) {}
    }
    .padding()
    .preferredColorScheme(.dark)
}
