//
//  DocsSummaryCard.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//

import SwiftUI

struct DocsSummaryCard: View {
    let title: String
    let content: String
    let isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack(spacing: 8) {
                Circle()
                    .fill(.white)
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(FontStyle.bold2.font)
                    .foregroundStyle(isDocs ? .blueMain : .yellowMain)
            }
            
            // 본문 내용
            Text(content)
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
                .foregroundStyle(.textGray)
            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .background(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1))
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}
