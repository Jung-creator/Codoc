//
//  DocsSummaryCard.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//

import SwiftUI

// HighlightText를 처리하는 유틸리티 함수
func createHighlightedText(from highlightText: HighlightText) -> AttributedString {
    var attributedString = AttributedString(highlightText.content)
    
    for highlight in highlightText.highlights {
        if let range = attributedString.range(of: highlight) {
            attributedString[range].font = FontStyle.bold1.font
            attributedString[range].foregroundColor = .blueMain
        }
    }
    
    return attributedString
}

struct DocsSummaryCard: View {
    let title: String
    let content: String
    var isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack {
                Image("target")
                    .resizable()
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1))
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}

// HighlightText를 받는 새로운 카드 컴포넌트
struct DocsSummaryHighlightCard: View {
    let title: String
    let highlightText: HighlightText
    var isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack(spacing: 8) {
                Image("gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(FontStyle.bold2.font)
                    .foregroundStyle(isDocs ? .blueMain : .yellowMain)
            }
            
            // 본문 내용 (강조 처리된 텍스트)
            Text(createHighlightedText(from: highlightText))
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
            
            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1))
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}

struct DocsSummaryHalfCard: View {
    let title: String
    let content: String
    let isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack(spacing: 8) {
                Image("gear")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(title)
                    .font(FontStyle.bold2.font)
                    .foregroundStyle(isDocs ? .blueMain : .yellowMain)
            }
            .padding(.bottom, 4)
            
            
            // 본문 내용
            Text(content)
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
                .foregroundStyle(.textGray)
            
            Spacer()
            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .frame(width: 172, height: 200)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1))
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}

// HighlightText를 받는 새로운 하프 카드 컴포넌트
struct DocsSummaryHighlightHalfCard: View {
    let title: String
    let highlightText: HighlightText
    let isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack(spacing: 8) {
                Image("location-mark")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(FontStyle.bold2.font)
                    .foregroundStyle(isDocs ? .blueMain : .yellowMain)
            }
            .padding(.bottom, 4)
            
            
            // 본문 내용 (강조 처리된 텍스트)
            Text(createHighlightedText(from: highlightText))
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
            
            Spacer()
            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .frame(width: 172, height: 200)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1))
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}

struct DocsSummaryChipCard: View {
    let title: String
    let keywords: [String]
    let isDocs: Bool = true
    
    var body: some View {
        // 문서 요약 카드 컴포넌트
        VStack(alignment: .leading, spacing: 16) {
            // 제목 부분
            HStack(spacing: 8) {
                Image("arrow-up")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(FontStyle.bold2.font)
                    .foregroundStyle(isDocs ? .blueMain : .yellowMain)
            }
            .padding(.bottom, 4)
            
            
            // 본문 내용
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(keywords, id: \.self) { keyword in
                        ChipView(content: keyword)
                    }
                }
            }
            
            
            // 하단 문구
            Text(isDocs ? "Based on the official documentation" : "Created by Solar")
                .font(FontStyle.regular1.font)
                .foregroundStyle(.captionGray)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDocs ? .blueMain.opacity(0.05) : .yellowMain.opacity(0.1)))
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isDocs ? .blueMain.opacity(0.5) : .yellowMain.opacity(0.5), lineWidth: 1)
        )
    }
}
