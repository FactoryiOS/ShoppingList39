//
//  MenuButton.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 28.10.2026.
//

import SwiftUI

struct MenuButton: View {
    @AppStorage(AppStorageKeys.appTheme)
    private var themeRawValue = AppTheme.system.rawValue

    @AppStorage(AppStorageKeys.isListsSortedByName)
    private var isSortedByName = false

    var body: some View {
        Menu {
            Menu {
                Picker("Тема", selection: $themeRawValue) {
                    Text("Светлая")
                        .tag(AppTheme.light.rawValue)

                    Text("Темная")
                        .tag(AppTheme.dark.rawValue)

                    Text("Системная")
                        .tag(AppTheme.system.rawValue)
                }
            } label: {
                Label(
                    "Установить тему",
                    systemImage: "circle.lefthalf.filled"
                )
            }

            Toggle(isOn: $isSortedByName) {
                Label(
                    "Сортировать по алфавиту",
                    systemImage: "arrow.up.arrow.down"
                )
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .foregroundStyle(.primary)
    }
}
