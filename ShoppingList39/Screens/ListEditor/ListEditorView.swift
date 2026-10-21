//
//  ListEditorView.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 21.10.2026.
//

import SwiftUI

struct ListEditorView: View {
    @State private var observed: Observed

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    init(mode: Mode, onSave: @escaping (Result) -> Void) {
        _observed = State(initialValue: Observed(mode: mode, onSave: onSave))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                BaseTextField(placeholder: "Введите название списка", text: $observed.name)

                ColorPickerBlock(selection: $observed.color, selectionColor: .uncategorizedTurquoise)

                ListIconPicker(selection: $observed.icon, selectionColor: observed.iconSelectionColor)
            }
            .padding(16)
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            BaseButton(title: observed.buttonTitle, isActive: observed.isSaveActive) {
                observed.handleSave()
                dismiss()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(observed.title)
                    .font(.headlineSemibold)
            }
        }
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemBackground) : .backgroundLight
    }
}

// MARK: - Preview

#Preview("Create Light") {
    NavigationStack {
        ListEditorView(mode: .create) { _ in }
    }
    .preferredColorScheme(.light)
}

#Preview("Create Dark") {
    NavigationStack {
        ListEditorView(mode: .create) { _ in }
    }
    .preferredColorScheme(.dark)
}

#Preview("Edit Light") {
    NavigationStack {
        ListEditorView(mode: .edit(name: "Новый год", color: .blue, icon: .snowflake)) { _ in }
    }
    .preferredColorScheme(.light)
}

#Preview("Edit Dark") {
    NavigationStack {
        ListEditorView(mode: .edit(name: "Новый год", color: .blue, icon: .snowflake)) { _ in }
    }
    .preferredColorScheme(.dark)
}
