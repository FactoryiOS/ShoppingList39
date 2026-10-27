//
//  AppTheme.swift
//  ShoppingList39
//
//  Created by Олег Сергеевич on 28.10.2026.
//

import SwiftUI

enum AppTheme: String {
    case light
    case system
    case dark

    var colorScheme: ColorScheme? {
        switch self {
        case .light:
                .light
        case .dark:
                .dark
        case .system:
            nil
        }
    }
}
