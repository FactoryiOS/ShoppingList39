import Foundation
import SwiftData

/// Товар в списке покупок.
@Model
final class ShoppingItem: Identifiable {
    var id: UUID
    var name: String
    var quantity: Double
    var unit: ShoppingUnit
    var isPurchased: Bool
    var createdAt: Date = Date()
    var sortOrder: Int = 0
    var list: ListItem?

    init(
        id: UUID = UUID(),
        name: String,
        quantity: Double,
        unit: ShoppingUnit,
        isPurchased: Bool = false
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.isPurchased = isPurchased
    }

    static var mock: ShoppingItem {
        ShoppingItem(
            name: "Чайник",
            quantity: 2,
            unit: .pieces
        )
    }
}
