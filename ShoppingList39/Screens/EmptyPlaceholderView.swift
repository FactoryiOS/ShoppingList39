//
//  EmptyPlaceholderView.swift
//  ShoppingList39
//
//  Created by Наринэ  Овсепян on 10.10.2026.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(imageName)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.headlineSemibold)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button(action: action) {
                Text(buttonTitle)
                    .font(.largeTitleRegular)
                    .background(Color.uncategorizedTurquoise)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
    }
}
