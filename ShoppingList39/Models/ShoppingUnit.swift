import Foundation

nonisolated enum ShoppingUnit: String, Codable, CaseIterable {
    case pieces = "шт"
    case kilograms = "кг"
    case grams = "г"
    case liters = "л"
    case milliliters = "мл"

    var title: String {
        switch self {
        case .pieces: String(localized: "шт")
        case .kilograms: String(localized: "кг")
        case .grams: String(localized: "г")
        case .liters: String(localized: "л")
        case .milliliters: String(localized: "мл")
        }
    }
}
