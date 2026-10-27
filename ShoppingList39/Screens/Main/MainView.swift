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

    init(observed: Observed? = nil) {
        _observed = State(initialValue: observed ?? Observed())
    }

    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .safeAreaInset(edge: .bottom) {
                    createButton
                }
                .navigationTitle("Мои списки")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ThemeMenu()
                    }
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
                ListItemCell(item: list)
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
            observed.handleEdit(list)
        } label: {
            Image(systemName: "square.and.pencil")
        }
        .tint(colorScheme == .dark ? .systemsDarkGrey : .systemsLightGrey)
    }

    // MARK: - Controls

    private var createButton: some View {
        BaseButton(title: "Создать список") {
            observed.handleCreateList()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    // MARK: - Colors

    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .backgroundLight
    }
}

// MARK: - Preview

#Preview("Empty") {
    MainView(observed: .init(lists: []))
}

#Preview("Data") {
    MainView(observed: .init(lists: ListItem.mocks))
}
