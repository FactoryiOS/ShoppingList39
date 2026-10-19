//
//  ColorPickerBlock.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 13.10.2026.
//

import SwiftUI

struct ColorPickerBlock: View {
    @Binding var selection: ListColor?
    let selectionColor: Color
    @Environment(\.colorScheme) private var colorScheme
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 5)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Выберите цвет")
                .font(.calloutRegular)
                .foregroundStyle(.primary)
            HStack(spacing: 12) {
                ForEach(ListColor.allCases) { appColor in
                    colorButton(appColor)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(12)
        .background(cardColor, in: RoundedRectangle(cornerRadius: 12))
    }
    private func colorButton(_ color: ListColor) -> some View {
        let isSelected = color == selection
        return Button {
            selection = color
        } label: {
            ZStack {
                Circle()
                    .fill(color.color)
                    .frame(width: 40, height: 40)
                
                if isSelected {
                    Circle()
                        .stroke(selectionColor, lineWidth: 2)
                        .frame(width: 52, height: 52)
                }
            }
        }
        .frame(width: 54, height: 54)
        .buttonStyle(.plain)
        .animation(.snappy(duration: 0.1), value: isSelected)
    }
    private var cardColor: Color {
        colorScheme == .dark ? .backgroundDark : .uncategorizedWhite
    }
}

private struct ColorPickerBlockPreview: View {
    @State private var color: ListColor?
    
    var body: some View {
        ColorPickerBlock(selection: $color, selectionColor: .uncategorizedTurquoise)
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color(.systemGroupedBackground))
    }
}

#Preview("Light") {
    ColorPickerBlockPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ColorPickerBlockPreview()
        .preferredColorScheme(.dark)
}
