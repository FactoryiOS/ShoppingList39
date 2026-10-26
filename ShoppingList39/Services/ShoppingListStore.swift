import Foundation
import SwiftData

@MainActor
final class ShoppingListStore {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    @discardableResult
    func createList(
        name: String,
        icon: ListIcon,
        color: ListColor
    ) throws -> ListItem {
        let list = ListItem(name: try validatedName(name), icon: icon, color: color)
        try save {
            context.insert(list)
        }
        return list
    }

    func updateList(
        _ list: ListItem,
        name: String,
        icon: ListIcon,
        color: ListColor
    ) throws {
        let name = try validatedName(name)
        let previousValues = (list.name, list.icon, list.color)
        try save(restoring: {
            (list.name, list.icon, list.color) = previousValues
        }, changes: {
            list.name = name
            list.icon = icon
            list.color = color
        })
    }

    @discardableResult
    func duplicateList(_ list: ListItem) throws -> ListItem {
        let items = list.sortedItems.enumerated().map { index, item in
            let copy = ShoppingItem(
                name: item.name,
                quantity: item.quantity,
                unit: item.unit,
                isPurchased: item.isPurchased
            )
            copy.createdAt = item.createdAt
            copy.sortOrder = index
            return copy
        }
        let copy = ListItem(
            name: "\(list.name) (копия)",
            icon: list.icon,
            color: list.color,
            items: items
        )
        try save {
            context.insert(copy)
        }
        return copy
    }

    func deleteList(_ list: ListItem) throws {
        let previousItems = list.items
        try save(restoring: {
            list.items = previousItems
        }, changes: {
            context.delete(list)
        })
    }

    @discardableResult
    func addItem(
        to list: ListItem,
        name: String,
        quantity: Double,
        unit: ShoppingUnit
    ) throws -> ShoppingItem {
        let name = try validatedName(name)
        try validateQuantity(quantity)
        let item = ShoppingItem(name: name, quantity: quantity, unit: unit)
        item.sortOrder = (list.items.map(\.sortOrder).max() ?? -1) + 1
        let previousItems = list.items
        try save(restoring: {
            list.items = previousItems
        }, changes: {
            context.insert(item)
            list.items.append(item)
        })
        return item
    }

    func updateItem(
        _ item: ShoppingItem,
        name: String,
        quantity: Double,
        unit: ShoppingUnit
    ) throws {
        let name = try validatedName(name)
        try validateQuantity(quantity)
        let previousValues = (item.name, item.quantity, item.unit)
        try save(restoring: {
            (item.name, item.quantity, item.unit) = previousValues
        }, changes: {
            item.name = name
            item.quantity = quantity
            item.unit = unit
        })
    }

    func deleteItem(_ item: ShoppingItem) throws {
        let list = item.list
        let previousItems = list?.items
        try save(restoring: {
            item.list = list
            if let list, let previousItems {
                list.items = previousItems
            }
        }, changes: {
            item.list?.items.removeAll { $0.id == item.id }
            context.delete(item)
        })
    }

    func deletePurchasedItems(from list: ListItem) throws {
        let previousItems = list.items
        let purchasedItems = previousItems.filter(\.isPurchased)
        guard !purchasedItems.isEmpty else { return }
        try save(restoring: {
            list.items = previousItems
        }, changes: {
            list.items.removeAll(where: \.isPurchased)
            for item in purchasedItems {
                context.delete(item)
            }
        })
    }

    func togglePurchased(_ item: ShoppingItem) throws {
        let wasPurchased = item.isPurchased
        try save(restoring: {
            item.isPurchased = wasPurchased
        }, changes: {
            item.isPurchased.toggle()
        })
    }

    private func save(restoring restore: () -> Void = {}, changes: () -> Void) throws {
        changes()
        do {
            try context.save()
        } catch {
            restore()
            context.rollback()
            throw error
        }
    }

    private func validatedName(_ name: String) throws -> String {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { throw ValidationError.emptyName }
        return name
    }

    private func validateQuantity(_ quantity: Double) throws {
        guard quantity.isFinite, quantity > 0 else { throw ValidationError.invalidQuantity }
    }

    private enum ValidationError: LocalizedError {
        case emptyName
        case invalidQuantity

        var errorDescription: String? {
            switch self {
            case .emptyName: "Введите название."
            case .invalidQuantity: "Количество должно быть больше нуля."
            }
        }
    }
}
