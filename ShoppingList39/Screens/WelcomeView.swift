//
//  WelcomeView.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 17.10.2026.
//

import SwiftUI

struct WelcomeView: View {
    let onStart: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            VStack(spacing: 48) {
                Text("Добро пожаловать!")
                    .font(.largeTitleRegular)

                Image(.manWithLongList)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 33)

                VStack(spacing: 12) {
                    Text("Никогда не забывайте, что нужно купить")
                        .font(.title2Semibold)

                    Text("Создавайте списки и не переживайте о покупках")
                        .font(.bodyRegular)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 39.3)

            Spacer()

            BaseButton(title: "Начать", isActive: true) {
                onStart()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
        .background(colorScheme == .dark ? .backgroundDark : .backgroundLight)
    }
}

#Preview("Light") {
    WelcomeView(onStart: {})
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    WelcomeView(onStart: {})
        .preferredColorScheme(.dark)
}
