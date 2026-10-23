/// Единицы измерения товара для отображения и выбора в пикере.
enum ShoppingUnit: String, Codable, CaseIterable {
    case pieces = "шт"
    case kilograms = "кг"
    case grams = "г"
    case liters = "л"
    case milliliters = "мл"
}
