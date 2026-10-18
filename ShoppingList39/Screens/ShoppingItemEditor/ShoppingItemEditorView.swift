import SwiftUI

/// Форма создания и редактирования товара.
struct ShoppingItemEditorView: View {
    
    enum Mode {
        case create
        case edit(ShoppingItem)

        var title: String {
            switch self {
            case .create: "Создание товара"
            case .edit: "Редактировать"
            }
        }
    }

    struct Values {
        let name: String
        let quantity: Double
        let unit: ShoppingUnit
    }
    
    private let mode: Mode
    private let onSave: (Values) -> Void

    @State private var formState: FormState
    @State private var isUnitPickerExpanded = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    init(mode: Mode = .create, onSave: @escaping (Values) -> Void) {
        self.mode = mode
        self.onSave = onSave
        _formState = State(initialValue: FormState(mode: mode))
    }

    var body: some View {
        @Bindable var formState = formState

        VStack(spacing: 8) {
            header

            ScrollView {
                VStack(spacing: 20) {
                    BaseTextField(placeholder: "Название товара", text: $formState.name)
                        .textInputAutocapitalization(.sentences)
                        .submitLabel(.done)

                    HStack(alignment: .top, spacing: 16) {
                        BaseTextField(placeholder: "Количество", text: $formState.quantity)
                            .keyboardType(.decimalPad)

                        unitPicker
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .padding(.top, 12)
        .background(backgroundColor)
        .presentationBackground(backgroundColor)
        .presentationDragIndicator(.visible)
        .presentationDetents([.large])
        .presentationCornerRadius(16)
    }

    private var header: some View {
        HStack(spacing: 8) {
            Button("Отменить") {
                dismiss()
            }
            .font(.bodyRegular)
            .foregroundStyle(Color.greyHint)

            Text(mode.title)
                .font(.headlineSemibold)
                .frame(maxWidth: .infinity)

            Button("Готово", action: handleSave)
                .font(.headlineSemibold)
                .foregroundStyle(formState.isSaveEnabled
                                 ? Color.uncategorizedTurquoise
                                 : Color.greyHint
                )
                .disabled(!formState.isSaveEnabled)
        }
        .buttonStyle(.plain)
        .frame(minHeight: 44)
        .padding(.horizontal, 16)
    }

    private var unitPicker: some View {
        VStack(spacing: 8) {
            Button {
                isUnitPickerExpanded.toggle()
            } label: {
                HStack(spacing: 8) {
                    Text(formState.unit.rawValue)
                        .font(.bodyRegular)
                        .foregroundStyle(.primary)

                    Spacer(minLength: 0)

                    if isUnitPickerExpanded {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(Color.greyHint)
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(unitPickerBackground, in: RoundedRectangle(cornerRadius: 12))
            }

            if isUnitPickerExpanded {
                unitOptions
            }
        }
        .buttonStyle(.plain)
    }

    private var unitOptions: some View {
        VStack(spacing: 4) {
            ForEach(ShoppingUnit.allCases, id: \.self) { unit in
                Button {
                    formState.unit = unit
                    isUnitPickerExpanded = false
                } label: {
                    HStack {
                        Text(unit.rawValue)
                            .font(.bodyRegular)

                        Spacer(minLength: 8)

                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .overlay {
                                if formState.unit == unit {
                                    Circle().padding(5)
                                }
                            }
                            .foregroundStyle(formState.unit == unit
                                             ? Color.uncategorizedTurquoise
                                             : Color.greyButton)
                            .frame(width: 24, height: 24)
                    }
                    .foregroundStyle(.primary)
                    .frame(height: 44)
                    .contentShape(Rectangle())
                }

                if unit != ShoppingUnit.allCases.last {
                    Divider()
                        .overlay(Color.greyStrokePanelIOS)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(unitPickerBackground, in: RoundedRectangle(cornerRadius: 12))
    }

    private var unitPickerBackground: Color {
        colorScheme == .dark
            ? .backgroundDark
            : .uncategorizedWhite
    }

    private var backgroundColor: Color {
        colorScheme == .dark
            ? .backgroundSheetDark
            : .backgroundLight
    }

    private func handleSave() {
        guard let values = formState.values else { return }
        onSave(values)
        dismiss()
    }
}

// MARK: - Preview

private struct ShoppingItemEditorPreview: View {
    let mode: ShoppingItemEditorView.Mode
    let colorScheme: ColorScheme
    @State private var isPresented = true

    var body: some View {
        Button("Открыть форму товара") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            ShoppingItemEditorView(mode: mode)
            { _ in }
                .preferredColorScheme(colorScheme)
        }
    }
}

#Preview("Создание") {
    ShoppingItemEditorPreview(mode: .create, colorScheme: .light)
}

#Preview("Редактирование") {
    ShoppingItemEditorPreview(
        mode: .edit(ShoppingItem.mock),
        colorScheme: .light
    )
}

#Preview("Редактирование - Dark") {
    ShoppingItemEditorPreview(
        mode: .edit(ShoppingItem.mock),
        colorScheme: .dark
    )
}
