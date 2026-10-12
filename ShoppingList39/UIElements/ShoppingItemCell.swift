import SwiftUI

/// Ячейка товара.
struct ShoppingItemCell: View {
    let item: ShoppingItem
    let onTogglePurchased: () -> Void

    private var textColor: Color {
        item.isPurchased ? .greyHint : .primary
    }

    var body: some View {
        HStack(spacing: 8) {
            purchaseButton

            Text(item.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)

            Text("\(item.quantity.formatted()) \(item.unit)")
                .fixedSize()
        }
        .font(.bodyRegular)
        .foregroundStyle(textColor)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }

    private var purchaseButton: some View {
        Button(action: onTogglePurchased) {
            ZStack {
                if item.isPurchased {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.uncategorizedTurquoise)

                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.uncategorizedWhite)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(.greyHint, lineWidth: 2)
                }
            }
            .frame(width: 24, height: 24)
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct ShoppingItemCellPreview: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var items: [ShoppingItem] = {
        let notPurchased = ShoppingItem.mock
        let purchased = ShoppingItem.mock
        purchased.isPurchased = true
        return [notPurchased, purchased]
    }()

    var body: some View {
        VStack(spacing: 0) {
            ShoppingItemCell(item: items[0]) {
                items[0].isPurchased.toggle()
            }

            Divider()
                .overlay(.greyStrokePanelIOS)

            ShoppingItemCell(item: items[1]) {
                items[1].isPurchased.toggle()
            }
        }
        .background(colorScheme == .dark
                    ? Color.backgroundDark
                    : Color.backgroundLight
        )
    }
}

#Preview("Light") {
    ShoppingItemCellPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ShoppingItemCellPreview()
        .preferredColorScheme(.dark)
}
