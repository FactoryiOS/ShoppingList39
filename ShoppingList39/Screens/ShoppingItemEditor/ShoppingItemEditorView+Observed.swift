import Foundation
import Observation

extension ShoppingItemEditorView {
    @MainActor
    @Observable
    final class Observed {
        var name: String
        var quantity: String
        var unit: ShoppingUnit
        let error = ErrorState()

        private var values: Values? {
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            let normalizedQuantity = quantity
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .replacingOccurrences(of: ",", with: ".")

            guard !trimmedName.isEmpty,
                  let quantity = Double(normalizedQuantity),
                  quantity.isFinite,
                  quantity > 0 else {
                return nil
            }

            return Values(name: trimmedName, quantity: quantity, unit: unit)
        }

        private let onSave: (Values) throws -> Void
        private let otherItems: [ShoppingItem]

        init(
            mode: Mode,
            existingItems: [ShoppingItem] = [],
            onSave: @escaping (Values) throws -> Void
        ) {
            self.onSave = onSave
            switch mode {
            case .create:
                name = ""
                quantity = ""
                unit = .pieces
                otherItems = existingItems
            case .edit(let item):
                name = item.name
                unit = item.unit
                quantity = item.quantity.formatted(
                    .number.grouping(.never).precision(.fractionLength(0...))
                )
                otherItems = existingItems.filter { $0.id != item.id }
            }
        }
        
        var isDuplicate: Bool {
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedName.isEmpty else { return false }
            return otherItems.contains {
                $0.name.localizedCaseInsensitiveCompare(trimmedName) == .orderedSame
            }
        }

        var nameError: String? {
            isDuplicate ? "Этот товар уже есть в списке, добавьте другой" : nil
        }

        var isSaveEnabled: Bool {
            values != nil && !isDuplicate
        }

        func handleSave() -> Bool {
            guard let values, !isDuplicate else { return false }
            return error.handle {
                try onSave(values)
            }
        }
    }
}
