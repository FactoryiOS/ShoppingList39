import Foundation
import Observation

extension ShoppingItemEditorView {
    @Observable
    final class FormState {
        var name: String
        var quantity: String
        var unit: ShoppingUnit

        init(mode: Mode) {
            switch mode {
            case .create:
                name = ""
                quantity = ""
                unit = .pieces
            case .edit(let item):
                name = item.name
                unit = item.unit
                quantity = String(item.quantity)
                if quantity.hasSuffix(".0") {
                    quantity.removeLast(2)
                }
            }
        }

        var isSaveEnabled: Bool {
            values != nil
        }

        var values: Values? {
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
    }
}
