//
//  Font+Styles.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 07.10.2026.
//

import SwiftUI

extension Font {
    // MARK: - Large Title — 34 / 41

    static let largeTitleRegular = Font.system(.largeTitle, weight: .regular)
    static let largeTitleSemibold = Font.system(.largeTitle, weight: .semibold)

    // MARK: - Title 1 — 28 / 34

    static let title1Regular = Font.system(.title, weight: .regular)
    static let title1Semibold = Font.system(.title, weight: .semibold)

    // MARK: - Title 2 — 22 / 28

    static let title2Regular = Font.system(.title2, weight: .regular)
    static let title2Semibold = Font.system(.title2, weight: .semibold)

    // MARK: - Title 3 — 20 / 25

    static let title3Regular = Font.system(.title3, weight: .regular)
    static let title3Semibold = Font.system(.title3, weight: .semibold)

    // MARK: - Headline / Body — 17 / 22

    static let headlineSemibold = Font.system(.headline, weight: .semibold)
    static let bodyRegular = Font.system(.body, weight: .regular)

    // MARK: - Callout — 16 / 21

    static let calloutRegular = Font.system(.callout, weight: .regular)
    static let calloutSemibold = Font.system(.callout, weight: .semibold)

    // MARK: - Subheading — 15 / 20

    static let subheadingRegular = Font.system(.subheadline, weight: .regular)
    static let subheadingMedium = Font.system(.subheadline, weight: .medium)

    // MARK: - Footnote — 13 / 18

    static let footnoteRegular = Font.system(.footnote, weight: .regular)
    static let footnoteSemibold = Font.system(.footnote, weight: .semibold)

    // MARK: - Caption 1 — 12 / 16

    static let caption1Light = Font.system(.caption, weight: .light)
    static let caption1Medium = Font.system(.caption, weight: .medium)

    // MARK: - Caption 2 — 11 / 13

    static let caption2Light = Font.system(.caption2, weight: .light)
    static let caption2Semibold = Font.system(.caption2, weight: .semibold)
}

#Preview {
    let styles: [(name: String, font: Font)] = [
        ("LargeTitle/Regular", .largeTitleRegular),
        ("LargeTitle/Semibold", .largeTitleSemibold),
        ("Title1/Regular", .title1Regular),
        ("Title1/Semibold", .title1Semibold),
        ("Title2/Regular", .title2Regular),
        ("Title2/Semibold", .title2Semibold),
        ("Title3/Regular", .title3Regular),
        ("Title3/Semibold", .title3Semibold),
        ("Headline", .headlineSemibold),
        ("Body", .bodyRegular),
        ("Callout/Regular", .calloutRegular),
        ("Callout/Semibold", .calloutSemibold),
        ("Subheading/Regular", .subheadingRegular),
        ("Subheading/Medium", .subheadingMedium),
        ("Footnote/Regular", .footnoteRegular),
        ("Footnote/Semibold", .footnoteSemibold),
        ("Caption1/Light", .caption1Light),
        ("Caption1/Medium", .caption1Medium),
        ("Caption2/Light", .caption2Light),
        ("Caption2/Semibold", .caption2Semibold)
    ]

    ScrollView {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(styles, id: \.name) { style in
                VStack(alignment: .leading, spacing: 4) {
                    Text(style.name)
                        .font(.caption1Light)
                        .foregroundStyle(.secondary)
                    Text("The quick brown fox jumps over the lazy dog.")
                        .font(style.font)
                }
            }
        }
        .padding()
    }
}
