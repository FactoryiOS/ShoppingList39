//
//  ListIcon.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 07.10.2026.
//

import SwiftUI

/// Иконка списка покупок.
/// Используется для хранения выбранного варианта в модели списка, например:
/// `var icon: ListIcon = .cart`.
/// Использование: для отображения — `icon.image`,
/// для построения интерфейса выбора — `ListIcon.allCases`.
enum ListIcon: String, CaseIterable, Identifiable, Codable {
    case snowflake
    case airplane
    case important
    case balloon
    case bandage
    case dumbbell
    case bed
    case briefcase
    case wrench
    case buildings
    case calendar
    case gift
    case palette
    case cart
    case car
    case food
    case pawprint
    case gamepad

    var id: String { rawValue }

    var systemName: String {
        switch self {
        case .snowflake: "snowflake"
        case .airplane: "airplane"
        case .important: "exclamationmark"
        case .balloon: "balloon"
        case .bandage: "bandage"
        case .dumbbell: "dumbbell"
        case .bed: "bed.double"
        case .briefcase: "briefcase"
        case .wrench: "wrench.adjustable"
        case .buildings: "building.2"
        case .calendar: "calendar"
        case .gift: "gift"
        case .palette: "paintpalette"
        case .cart: "cart"
        case .car: "car"
        case .food: "takeoutbag.and.cup.and.straw"
        case .pawprint: "pawprint"
        case .gamepad: "gamecontroller"
        }
    }

    var image: Image {
        Image(systemName: systemName)
    }
}

#Preview {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 12) {
        ForEach(ListIcon.allCases) { icon in
            icon.image
                .font(.system(size: 22))
                .foregroundStyle(.uncategorizedWhite)
                .frame(width: 48, height: 48)
                .background(.backgroundIconBackground, in: Circle())
        }
    }
    .padding()
}
