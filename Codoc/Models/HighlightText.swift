import Foundation

struct HighlightText: Codable {
    var content: String                // 본문
    var highlights: [String]           // 강조할 단어 리스트
}
