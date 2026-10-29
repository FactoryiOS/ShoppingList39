import Foundation
import SwiftData

/// Список покупок. 
@Model
final class ListItem {
    var id: UUID
    var name: String
    var icon: ListIcon
    var color: ListColor
    var createdAt: Date = Date()

    @Relationship(deleteRule: .cascade, inverse: \ShoppingItem.list)
    var items: [ShoppingItem]

    var sortedItems: [ShoppingItem] {
        items.sorted {
            if $0.sortOrder != $1.sortOrder {
                return $0.sortOrder < $1.sortOrder
            }
            return $0.createdAt < $1.createdAt
        }
    }

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
        color: ListColor = .blue,
        items: [ShoppingItem] = []
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
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

// MARK: - Mocks

extension ListItem {
    static var mocks: [ListItem] {
        [
            mock,
            makeMock(
                name: "Кошке",
                icon: .pawprint,
                totalCount: 4,
                purchasedCount: 1
            ),
            makeMock(
                name: "Вечеринка",
                icon: .gamepad,
                totalCount: 20,
                purchasedCount: 9
            ),
            makeMock(name: "Продукты", icon: .cart)
        ]
    }

    private static func makeMock(
        name: String,
        icon: ListIcon,
        totalCount: Int = 0,
        purchasedCount: Int = 0
    ) -> ListItem {
        let items = (0..<totalCount).map { index in
            let item = ShoppingItem.mock
            item.isPurchased = index < purchasedCount
            return item
        }

        return ListItem(
            name: name,
            icon: icon,
            items: items
        )
    }
}
