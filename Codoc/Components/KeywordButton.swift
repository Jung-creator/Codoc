//
//  KeywordButton.swift
//  Codoc
//
//  Created by Choi Jung In on 8/23/25.
//

import SwiftUI

// 얇은 Stroke가 있는 키워드 버튼 컴포넌트
struct KeywordButton: View {
    let title: String
    let borderColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(FontStyle.medium2.font)
                .foregroundStyle(.textGray)
                .lineLimit(1)
                .fixedSize()
//                .frame(maxWidth: .infinity)
                .padding(.horizontal, 12)
                .frame(height: DesignSystem.keywordButtonHeight)
                .background(borderColor.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: DesignSystem.keywordButtonRounding)
                        .stroke(borderColor.opacity(0.5), lineWidth: 1)
                )
        }
        .padding(2)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    KeywordButton(title: "MainActor", borderColor: .blueMain, action: {})
}
