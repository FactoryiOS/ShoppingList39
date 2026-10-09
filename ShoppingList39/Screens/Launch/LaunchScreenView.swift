//
//  LaunchScreenView.swift
//  ShoppingList39
//
//  Created by Gleb on 09.10.2026.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.backgroundLaunch
                .ignoresSafeArea()

            Image(.launchScreen)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    LaunchScreenView()
}
