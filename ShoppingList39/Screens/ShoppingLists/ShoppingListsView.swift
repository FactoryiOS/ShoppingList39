//
//  ShoppingListsView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 21.10.2026.
//

import SwiftUI
import SwiftData

struct ShoppingListsView: View {
    let list: ListItem

    @State private var observed: ShoppingListsViewObserved
    @Environment(\.modelContext) private var modelContext
    @Environment(Router.self) private var router

    init(list: ListItem) {
        self.list = list
        _observed = State(initialValue: ShoppingListsViewObserved(list: list))
    }

    var body: some View {
        VStack(spacing: 0) {
            if list.items.isEmpty {
                EmptyStateView(config: .shoppingList)
            } else {
                itemsContent
            }

            BaseButton(title: "Добавить товар") {
                router.showModal(.itemEditor(.create, list: list))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $observed.searchText, prompt: "Поиск")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(list.name)
                    .font(.headlineSemibold)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Редактировать список", systemImage: "square.and.pencil") {
                        router.push(.listEditor(.edit(list)))
                    }
                    Button(role: .destructive) {
                        observed.isDeletePurchasedPresented = true
                    } label: {
                        Label("Удалить купленные товары", systemImage: "trash")
                    }
                    .disabled(list.purchasedCount == 0)
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.primary)
                }
            }
        }
        .alert("Удаление товара", isPresented: $observed.isDeletePresented) {
            Button("Отменить", role: .cancel) {
                observed.itemToDelete = nil
            }
            Button("Удалить", role: .destructive) {
                observed.handleDelete(context: modelContext)
            }
        } message: {
            Text("Вы действительно хотите удалить товар?")
        }
        .alert("Удаление купленных товаров", isPresented: $observed.isDeletePurchasedPresented) {
            Button("Отменить", role: .cancel) {}
            Button("Удалить", role: .destructive) {
                observed.handleDeletePurchased(context: modelContext)
            }
        } message: {
            Text("Вы действительно хотите удалить все купленные товары?")
        }
        .errorAlert("Не удалось сохранить изменения", state: observed.error)
    }

    private var itemsContent: some View {
        List {
            ForEach(observed.filteredItems) { item in
                ShoppingItemCell(item: item) {
                    observed.togglePurchase(for: item, context: modelContext)
                }
                .listRowSeparator(.hidden)

                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.greyStrokePanelIOS)
                        .frame(height: 1)
                        .padding(.leading, 0)
                }

                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        observed.handleRequestDelete(item)
                    } label: {
                        Label("Удалить", systemImage: "trash")
                    }
                    .tint(.red)

                    Button {
                        router.showModal(.itemEditor(.edit(item), list: list))
                    } label: {
                        Label("Изменить", systemImage: "square.and.pencil")
                    }
                    .tint(.systemsLightGrey)
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(12)
    }
}

#Preview("Светлая тема") {
    RouterView {
        ShoppingListsView(list: .mock)
    }
    .preferredColorScheme(.light)
    .modelContainer(for: [ListItem.self, ShoppingItem.self], inMemory: true)
}
#Preview("Темная тема") {
    RouterView {
        ShoppingListsView(list: .mock)
    }
    .preferredColorScheme(.dark)
    .modelContainer(for: [ListItem.self, ShoppingItem.self], inMemory: true)
}
