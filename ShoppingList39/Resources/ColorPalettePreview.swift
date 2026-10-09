//
//  ColorPalettePreview.swift
//  ShoppingList39
//
//  Created by Vsevolod Oplachko on 07.10.2026.
//

import SwiftUI

private struct ColorPalettePreview: View {
    private let groups: [(title: String, colors: [(name: String, color: Color)])] = [
        ("Uncategorized", [
            ("turquoise", .uncategorizedTurquoise),
            ("Pressed", .uncategorizedPressed),
            ("White", .uncategorizedWhite)
        ]),
        ("background", [
            ("dark", .backgroundDark),
            ("light", .backgroundLight),
            ("icon background", .backgroundIconBackground),
            ("launch", .backgroundLaunch)
        ]),
        ("Grey", [
            ("button", .greyButton),
            ("grey 80 (для темной темы)", .greyGrey80),
            ("stroke panel IOS", .greyStrokePanelIOS),
            ("grey list", .greyGreyList),
            ("Hint", .greyHint)
        ]),
        ("Systems", [
            ("light/orange", .systemsLightOrange),
            ("light/grey", .systemsLightGrey),
            ("light/red", .systemsLightRed),
            ("dark/grey", .systemsDarkGrey),
            ("dark/orange", .systemsDarkOrange),
            ("dark/red", .systemsDarkRed)
        ]),
        ("M3", [
            ("black_70", .m3Black70)
        ]),
        ("additional color", [
            ("yellow_dark", .additionalYellowDark),
            ("red_dark", .additionalRedDark),
            ("blue_dark", .additionalBlueDark),
            ("purple_dark", .additionalPurpleDark),
            ("green_dark", .additionalGreenDark),
            ("yellow", .additionalYellow),
            ("red", .additionalRed),
            ("purple", .additionalPurple),
            ("green", .additionalGreen),
            ("Blue", .additionalBlue)
        ])
    ]

    var body: some View {
        List {
            ForEach(groups, id: \.title) { group in
                Section(group.title) {
                    ForEach(group.colors, id: \.name) { item in
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(item.color)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.separator)
                                }
                            Text(item.name)
                                .font(.bodyRegular)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview("Light") {
    ColorPalettePreview()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ColorPalettePreview()
        .preferredColorScheme(.dark)
}
