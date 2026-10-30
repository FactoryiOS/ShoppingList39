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
        private let knownNames: [String]
        private let isCreating: Bool
        private var selectedSuggestion: String?

        init(
            mode: Mode,
            existingItems: [ShoppingItem] = [],
            knownNames: [String] = [],
            onSave: @escaping (Values) throws -> Void
        ) {
            self.onSave = onSave
            self.knownNames = knownNames
            switch mode {
            case .create:
                name = ""
                quantity = ""
                unit = .pieces
                otherItems = existingItems
                isCreating = true
            case .edit(let item):
                name = item.name
                unit = item.unit
                quantity = item.quantity.formatted(
                    .number.grouping(.never).precision(.fractionLength(0...))
                )
                otherItems = existingItems.filter { $0.id != item.id }
                isCreating = false
            }
        }

        /// Подсказки названия: только при создании товара и пока подсказка не выбрана.
        var suggestions: [String] {
            guard isCreating, name != selectedSuggestion else { return [] }
            return ProductSuggestions.suggestions(
                for: name,
                history: knownNames,
                excluding: otherItems.map(\.name)
            )
        }

        func handleSelectSuggestion(_ suggestion: String) {
            selectedSuggestion = suggestion
            name = suggestion
        }
        
        var isDuplicate: Bool {
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedName.isEmpty else { return false }
            return otherItems.contains {
                $0.name.localizedCaseInsensitiveCompare(trimmedName) == .orderedSame
            }
        }

        var nameError: String? {
            isDuplicate ? String(localized: "Этот товар уже есть в списке, добавьте другой") : nil
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
