//
//  ListIconPicker.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 11.10.2026.
//

import SwiftUI

struct ListIconPicker: View {
    @Binding var selection: ListIcon?
    let selectionColor: Color

    @Environment(\.colorScheme) private var colorScheme

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Выберите дизайн")
                .font(.calloutRegular)
                .foregroundStyle(.primary)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(ListIcon.allCases) { icon in
                    iconButton(icon)
                }
            }
        }
        .padding(12)
        .background(cardColor, in: RoundedRectangle(cornerRadius: 12))
    }

    private func iconButton(_ icon: ListIcon) -> some View {
        let isSelected = icon == selection

        return Button {
            selection = icon
        } label: {
            icon.image
                .font(.title2Regular)
                .foregroundStyle(isSelected ? Color.backgroundDark : iconColor)
                .frame(width: 48, height: 48)
                .background(isSelected ? selectionColor : .backgroundIconBackground, in: Circle())
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .accessibilityLabel(icon.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var cardColor: Color {
        colorScheme == .dark ? .backgroundDark : .uncategorizedWhite
    }
    
    private var iconColor: Color {
        colorScheme == .dark ? .backgroundDark : .uncategorizedWhite
    }
}

// MARK: - Preview

private struct ListIconPickerPreview: View {
    @State private var icon: ListIcon? = .snowflake

    var body: some View {
        ListIconPicker(selection: $icon, selectionColor: .additionalBlue)
            .padding()
            .frame(maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

#Preview("Light") {
    ListIconPickerPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ListIconPickerPreview()
        .preferredColorScheme(.dark)
}
