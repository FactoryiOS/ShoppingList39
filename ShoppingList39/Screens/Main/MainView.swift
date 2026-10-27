//
//  MainView.swift
//  ShoppingList39
//
//  Created by Gleb on 21.10.2026.
//

import SwiftUI

struct MainView: View {
    @State private var observed: Observed

    @Environment(\.colorScheme) private var colorScheme
    @Environment(Router.self) private var router

    init(observed: Observed? = nil) {
        _observed = State(initialValue: observed ?? Observed())
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .safeAreaInset(edge: .bottom) {
                createButton
            }
            .navigationTitle("Мои списки")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    menuButton
                }
            }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if observed.isEmpty {
            EmptyStateView(config: .lists)
        } else {
            listView
        }
    }

    private var listView: some View {
        List {
            ForEach(observed.lists) { list in
                Button {
                    router.push(.shoppingList(list))
                } label: {
                    ListItemCell(item: list)
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    swipeButtons(for: list)
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(12)
        .scrollContentBackground(.hidden)
    }

    @ViewBuilder
    private func swipeButtons(for list: ListItem) -> some View {
        Button {
            observed.handleDelete(list)
        } label: {
            Image(systemName: "trash")
        }
        .tint(colorScheme == .dark ? .systemsDarkRed : .systemsLightRed)

        Button {
            observed.handleCopy(list)
        } label: {
            Image(systemName: "plus.square.on.square")
        }
        .tint(colorScheme == .dark ? .systemsDarkOrange : .systemsLightOrange)

        Button {
            // TODO: передавать цвет списка, когда он появится в ListItem
            router.push(.listEditor(.edit(name: list.name, color: .blue, icon: list.icon)))
        } label: {
            Image(systemName: "square.and.pencil")
        }
        .tint(colorScheme == .dark ? .systemsDarkGrey : .systemsLightGrey)
    }

    // MARK: - Controls

    private var createButton: some View {
        BaseButton(title: "Создать список") {
            router.push(.listEditor(.create))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }

    private var menuButton: some View {
        Button {
            observed.handleMenuTap()
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .foregroundStyle(.primary)
    }

    // MARK: - Colors

    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .backgroundLight
    }
}

// MARK: - Preview

#Preview("Empty") {
    RouterView {
        MainView(observed: .init(lists: []))
    }
}

#Preview("Data") {
    RouterView {
        MainView(observed: .init(lists: ListItem.mocks))
    }
}
