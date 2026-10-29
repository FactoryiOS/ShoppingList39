//
//  MainView.swift
//  ShoppingList39
//
//  Created by Gleb on 21.10.2026.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query(sort: [
        SortDescriptor(\ListItem.createdAt, order: .reverse),
        SortDescriptor(\ListItem.name)
    ])
    private var lists: [ListItem]
    @State private var observed = Observed()

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext
    @Environment(Router.self) private var router

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
                    MenuButton()
                }
            }
            .alert("Удаление списка", isPresented: $observed.isDeletePresented) {
                Button("Отменить", role: .cancel) {
                    observed.listToDelete = nil
                }
                Button("Удалить", role: .destructive) {
                    observed.handleDelete(context: modelContext)
                }
            } message: {
                Text("Вы действительно хотите удалить список?")
            }
            .errorAlert("Не удалось сохранить изменения", state: observed.error)
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if lists.isEmpty {
            EmptyStateView(config: .lists)
        } else {
            listView
        }
    }

    private var listView: some View {
        List {
            ForEach(lists) { list in
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
            observed.handleRequestDelete(list)
        } label: {
            Image(systemName: "trash")
        }
        .tint(colorScheme == .dark ? .systemsDarkRed : .systemsLightRed)

        Button {
            observed.handleCopy(list, context: modelContext)
        } label: {
            Image(systemName: "plus.square.on.square")
        }
        .tint(colorScheme == .dark ? .systemsDarkOrange : .systemsLightOrange)

        Button {
            router.push(.listEditor(.edit(list)))
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
    
    // MARK: - Colors

    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .backgroundLight
    }
}

// MARK: - Preview

#Preview("Empty") {
    RouterView {
        MainView()
    }
    .modelContainer(for: [ListItem.self, ShoppingItem.self], inMemory: true)
}

#Preview("Data") {
    let container: ModelContainer? = {
        guard let container = try? ModelContainer(
            for: ListItem.self, ShoppingItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        ) else { return nil }
        ListItem.mocks.forEach { container.mainContext.insert($0) }
        return container
    }()
    if let container {
        RouterView {
            MainView()
        }
        .modelContainer(container)
    }
}
