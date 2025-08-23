import Foundation

struct DocsSummary: Codable {
    var overview: HighlightText?       // 개요
    var codeSnippet: String?           // 예시 코드
    var typeInfo: String?              // 타입 정보 (struct, class, protocol 등)
    var usage: HighlightText?          // 사용하는 상황
    var caution: HighlightText?        // 주의 사항
    var relatedKeywords: [String]?     // 연관 키워드
    var aiFullSummary: HighlightText?  // AI가 전체 요약한 내용
}
