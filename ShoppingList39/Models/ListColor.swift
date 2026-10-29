//
//  ListColor.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 16.10.2026.
//

import SwiftUI

enum ListColor: String, Codable, CaseIterable, Identifiable {
    case blue
    case green
    case purple
    case red
    case yellow
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .blue:   .additionalBlue
        case .green:  .additionalGreen
        case .purple: .additionalPurple
        case .red:    .additionalRed
        case .yellow: .additionalYellow
        }
    }
}
