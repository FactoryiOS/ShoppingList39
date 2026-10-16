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
            
            VStack(spacing: 12) {
                Text(title)
                    .font(.largeTitleRegular)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.bodyRegular)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            Button(action: action) {
                Text(buttonTitle)
                    .font(.headlineSemibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.uncategorizedTurquoise)
                    .cornerRadius(24)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
    }
}
