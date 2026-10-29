//
//  ListEditorView+Observed.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 21.10.2026.
//

import SwiftUI

extension ListEditorView {
    enum Mode: Hashable, Identifiable {
        case create
        case edit(ListItem)

        var id: String {
            switch self {
            case .create: "create"
            case .edit(let list): list.id.uuidString
            }
        }
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
        let error = ErrorState()

        private let mode: Mode
        private let onSave: (Result) throws -> Void

        init(mode: Mode, onSave: @escaping (Result) throws -> Void) {
            self.mode = mode
            self.onSave = onSave

            switch mode {
            case .create:
                name = ""
                color = nil
                icon = nil
            case .edit(let list):
                name = list.name
                color = list.color
                icon = list.icon
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

        func handleSave() -> Bool {
            guard let color, let icon, !trimmedName.isEmpty else { return false }
            return error.handle {
                try onSave(Result(name: trimmedName, color: color, icon: icon))
            }
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
