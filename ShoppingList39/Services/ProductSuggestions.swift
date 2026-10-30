//
//  ProductSuggestions.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 29.10.2026.
//

import Foundation

enum ProductSuggestions {
    private enum Limits {
        static let maxCount = 3
    }

    static func suggestions(
        for query: String,
        history: [String],
        excluding excluded: [String]
    ) -> [String] {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return [] }

        var seen = Set(excluded.map { $0.lowercased() })
        seen.insert(query.lowercased())

        let matches = (history + products).filter { name in
            guard name.range(of: query, options: [.caseInsensitive, .anchored]) != nil else { return false }
            return seen.insert(name.lowercased()).inserted
        }

        return Array(
            matches
                .sorted { $0.localizedStandardCompare($1) == .orderedAscending }
                .prefix(Limits.maxCount)
        )
    }

    private static let products = [
        "Апельсины", "Бананы", "Батон", "Бекон", "Брокколи", "Булочки", "Вермишель", "Вино",
        "Вода", "Говядина", "Горошек", "Гречка", "Груши", "Джем", "Дрожжи", "Зелень",
        "Йогурт", "Кабачки", "Капуста", "Картофель", "Кефир", "Кетчуп", "Колбаса", "Кофе",
        "Крупа", "Курица", "Лимоны", "Лук", "Майонез", "Макароны", "Масло растительное",
        "Масло сливочное", "Молоко", "Морковь", "Мука", "Мёд", "Огурцы", "Овсянка", "Орехи",
        "Перец", "Печенье", "Помидоры", "Пельмени", "Рис", "Ряженка", "Рыба", "Сахар",
        "Свинина", "Сметана", "Сок", "Соль", "Сосиски", "Сыр", "Творог", "Туалетная бумага",
        "Хлеб", "Чай", "Чайник", "Чашка", "Чеснок", "Шоколад", "Яблоки", "Яйца"
    ]
}
