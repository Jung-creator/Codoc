//
//  CodeBlock.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//

import SwiftUI

struct CodeBlock: View {
    let content: String
    var isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {

            // 본문 내용
            Text(content)
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
                .foregroundStyle(.white)

            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.textGray)
        .background(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}
