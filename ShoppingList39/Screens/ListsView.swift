//
//  ListsView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 10.10.2026.
//

import SwiftUI

struct ListsView: View {
    @State private var lists: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                if lists.isEmpty {
                    EmptyPlaceholderView(
                        imageName: "notepadWithGlasses",
                        title: "Давайте спланируем покупки!",
                        subtitle: "Создайте свой первый список",
                        buttonTitle: "Создать список"
                    ) {
                        createNewList()
                    }
                } else {
                    List(lists, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Text("Мои списки")
                        .font(.title1Semibold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.primary)
                    })
                }
            }
        }
    }
    func createNewList() {
        print("Создать список")
    }
}

#Preview {
    ListsView()
}
