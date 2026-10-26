//
//  ListEditorView+Observed.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 21.10.2026.
//

import SwiftUI

extension ListEditorView {
    enum Mode {
        case create
        case edit(name: String, color: ListColor, icon: ListIcon)
    }

    struct Result {
        let name: String
        let color: ListColor
        let icon: ListIcon
    }

    @MainActor
    @Observable
    final class Observed {
        var name: String
        var color: ListColor?
        var icon: ListIcon?

        private let mode: Mode
        private let onSave: (Result) -> Void

        init(mode: Mode, onSave: @escaping (Result) -> Void) {
            self.mode = mode
            self.onSave = onSave

            switch mode {
            case .create:
                name = ""
                color = nil
                icon = nil
            case let .edit(name, color, icon):
                self.name = name
                self.color = color
                self.icon = icon
            }
        }

        var title: String {
            isEditing ? "Редактировать список" : "Создать список"
        }

        var buttonTitle: String {
            isEditing ? "Сохранить" : "Создать"
        }

        var iconSelectionColor: Color {
            (color ?? .blue).color
        }

        var isSaveActive: Bool {
            !trimmedName.isEmpty && color != nil && icon != nil
        }

        func handleSave() {
            guard let color, let icon, !trimmedName.isEmpty else { return }
            onSave(Result(name: trimmedName, color: color, icon: icon))
        }

        private var isEditing: Bool {
            if case .edit = mode { return true }
            return false
        }

        private var trimmedName: String {
            name.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
