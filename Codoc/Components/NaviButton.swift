//
//  NaviButton.swift
//  Codoc
//
//  Created by Choi Jung In on 8/23/25.
//

import SwiftUI

struct NaviButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(title)
                    .font(FontStyle.bold3.font)
                    .foregroundStyle(.white)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white)
            }
            .frame(height: 56)
            .padding(.horizontal, 32)
            .background(.blueMain)
            .cornerRadius(28) // 매우 둥근 모서리 (pill 모양)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        NaviButton(title: "문제 풀기") {
            print("문제 풀기 버튼 탭됨")
        }
        
        NaviButton(title: "학습 시작") {
            print("학습 시작 버튼 탭됨")
        }
    }
    .padding()
}
