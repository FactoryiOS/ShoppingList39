import SwiftUI

/// Карточка списка с иконкой, названием и количеством купленных товаров.
struct ListItemCell: View {
    let item: ListItem

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(spacing: 12) {
            icon
            title
            progress
        }
        .foregroundStyle(.primary)
        .padding(16)
        .frame(minHeight: 84)
        .background(
            colorScheme == .dark
                ? Color.backgroundDark
                : Color.uncategorizedWhite,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }

    private var icon: some View {
        item.icon.image
            .font(.system(size: 24))
            .foregroundStyle(.black)
            .frame(width: 48, height: 48)
            .background(.additionalBlue, in: Circle())
    }

    private var title: some View {
        Text(item.name)
            .font(.title3Semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var progress: some View {
        Text("\(item.purchasedCount)/\(Text(item.totalCount, format: .number).font(.headlineSemibold))")
            .font(.bodyRegular)
            .monospacedDigit()
            .fixedSize()
    }
}

private struct ListItemCellPreview: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var item = ListItem.mock

    var body: some View {
        ListItemCell(item: item)
            .padding(16)
            .background(colorScheme == .dark
                        ? Color.black
                        : .backgroundLight
            )
    }
}

#Preview("Light") {
    ListItemCellPreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ListItemCellPreview()
        .preferredColorScheme(.dark)
}

#Preview("Empty List") {
    ListItemCell(item: ListItem(name: "Покупки"))
        .padding(16)
        .background(.backgroundLight)
}
