//
//  ChipView.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//

import SwiftUI

struct ChipView: View {
    let content: String
    
    var body: some View {
        
        Text(content)
            .font(FontStyle.bold1.font)
            .foregroundStyle(.blueMain)
            .lineLimit(1)
            .fixedSize()
            .padding(.horizontal, 20)
            .frame(height: 36)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.blueMain.opacity(0.5), lineWidth: 2)
            )
    }
}
