import Foundation
import SwiftData

/// Список покупок. 
@Model
final class ListItem {
    var id: UUID
    var name: String
    var icon: ListIcon

    @Relationship(deleteRule: .cascade)
    var items: [ShoppingItem]

    var purchasedCount: Int {
        items.filter(\.isPurchased).count
    }

    var totalCount: Int {
        items.count
    }

    init(
        id: UUID = UUID(),
        name: String,
        icon: ListIcon = .cart,
        items: [ShoppingItem] = []
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.items = items
    }

    static var mock: ListItem {
        let items = (0..<MockValues.totalCount).map { index in
            let item = ShoppingItem.mock
            item.isPurchased = index < MockValues.purchasedCount
            return item
        }

        return ListItem(
            name: MockValues.name,
            icon: .calendar,
            items: items
        )
    }

    private enum MockValues {
        static let name = "Новый год"
        static let totalCount = 20
        static let purchasedCount = 10
    }
}
