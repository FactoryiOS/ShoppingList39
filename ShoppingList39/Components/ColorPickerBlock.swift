//
//  ColorPickerBlock.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 13.10.2026.
//

import SwiftUI

enum AppColor: String, CaseIterable, Identifiable {
    case blue = "additionalBlue"
    case green = "additionalGreen"
    case purple = "additionalPurple"
    case pink = "additionalRed"
    case yellow = "additionalYellow"
    
    var id: String { rawValue }
    
    var color: Color { Color(rawValue) }
}

struct ColorPickerBlock: View {
    @Binding var selection: AppColor
    let selectionColor: Color
    @Environment(\.colorScheme) private var colorScheme
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 5)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Выберите цвет")
                .font(.calloutRegular)
                .foregroundStyle(.primary)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(AppColor.allCases) { appColor in
                    colorButton(appColor)
                }
            }
        }
        .padding(12)
        .background(cardColor, in: RoundedRectangle(cornerRadius: 12))
    }
    private func colorButton(_ appColor: AppColor) -> some View {
        let isSelected = appColor == selection
        return Button {
            selection = appColor
        } label: {
            ZStack {
                Circle()
                    .fill(appColor.color)
                    .frame(width: 44, height: 44)
                
                if isSelected {
                    Circle()
                        .stroke(selectionColor, lineWidth: 2)
                        .frame(width: 54, height: 54)
                }
            }
        }
        .buttonStyle(.plain)
        .animation(.snappy(duration: 0.1), value: isSelected)
    }
    private var cardColor: Color {
        colorScheme == .dark ? .backgroundDark : .uncategorizedWhite
    }
}
    
    private struct ColorPickerBlockPreview: View {
        @State private var color: AppColor = .blue
        
        var body: some View {
            ColorPickerBlock(selection: $color, selectionColor: .additionalBlue)
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
