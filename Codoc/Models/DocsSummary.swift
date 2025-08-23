import Foundation

// 새로운 JSON 응답 형식에 맞는 DocsSummary 구조체
struct DocsSummary: Codable {
    let keywordSummary: KeywordSummary
    let quiz: Quiz
}

struct KeywordSummary: Codable {
    let overview: HighlightText
    let codeSnippet: String
    let features: [HighlightText]
    let caution: HighlightText
    let relatedKeywords: [String]
    let aiSummary: HighlightText
}

struct Quiz: Codable {
    let question: String
    let description: String
    let codeExample: String
    let options: [String]
    let answer: Answer
}

struct Answer: Codable {
    let location: String
    let reason: String
}

struct HighlightText: Codable {
    let content: String
    let highlights: [String]
}

// 편의를 위한 computed properties
extension DocsSummary {
    var overview: HighlightText { keywordSummary.overview }
    var codeSnippet: String { keywordSummary.codeSnippet }
    var features: [HighlightText] { keywordSummary.features }
    var caution: HighlightText { keywordSummary.caution }
    var relatedKeywords: [String] { keywordSummary.relatedKeywords }
    var aiSummary: HighlightText { keywordSummary.aiSummary }
}