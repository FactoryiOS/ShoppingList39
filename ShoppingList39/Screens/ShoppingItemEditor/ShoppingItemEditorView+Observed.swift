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

        init(mode: Mode, onSave: @escaping (Values) throws -> Void) {
            self.onSave = onSave
            switch mode {
            case .create:
                name = ""
                quantity = ""
                unit = .pieces
            case .edit(let item):
                name = item.name
                unit = item.unit
                quantity = item.quantity.formatted(
                    .number.grouping(.never).precision(.fractionLength(0...))
                )
            }
        }

        var isSaveEnabled: Bool {
            values != nil
        }

        func handleSave() -> Bool {
            guard let values else { return false }
            return error.handle {
                try onSave(values)
            }
        }
    }
}
