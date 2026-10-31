//
//  BaseTextField.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 11.10.2026.
//

import SwiftUI

struct BaseTextField: View {
    let placeholder: LocalizedStringKey
    @Binding var text: String
    var errorMessage: String?

    @Environment(\.colorScheme) private var colorScheme

    private var isError: Bool { errorMessage != nil }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                TextField(
                    text: $text,
                    prompt: Text(placeholder).foregroundStyle(Color.greyHint)
                ) {
                    Text(placeholder)
                }
                .font(.bodyRegular)

                if !text.isEmpty {
                    clearButton
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 54)
            .background(fieldColor, in: RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isError ? errorColor : .clear, lineWidth: 0.5)
            }

            if let errorMessage {
                Text(errorMessage)
                    .font(.footnoteRegular)
                    .foregroundStyle(errorColor)
                    .padding(.horizontal, 8)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
        .animation(.easeInOut(duration: 0.2), value: isError)
    }

    private var clearButton: some View {
        Button {
            text = ""
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Color.greyHint)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Очистить")
    }

    private var fieldColor: Color {
        colorScheme == .dark ? .backgroundDark : .uncategorizedWhite
    }

    private var errorColor: Color {
        colorScheme == .dark ? .systemsDarkRed : .systemsLightRed
    }
}

// MARK: - Preview

private struct BaseTextFieldPreview: View {
    @State private var emptyText = ""
    @State private var filledText = "Новый год"
    @State private var errorText = "Новый год"

    var body: some View {
        VStack(spacing: 16) {
            BaseTextField(placeholder: "Введите название списка", text: $emptyText)
            BaseTextField(placeholder: "Введите название списка", text: $filledText)
            BaseTextField(
                placeholder: "Введите название списка",
                text: $errorText,
                errorMessage: "Это название уже используется, пожалуйста, измените его."
            )
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview("Light") {
    BaseTextFieldPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    BaseTextFieldPreview()
        .preferredColorScheme(.dark)
}
