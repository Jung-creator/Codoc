import Foundation

struct SectionCard: Identifiable, Codable {
    let id: UUID = UUID()
    let title: String                  // 섹션 이름, ex) "개요", "예시 코드"
    let content: String                // 섹션 내용
    var isSelected: Bool = false       // 아카이빙 선택 상태
}

struct ArchivedKeyword: Identifiable, Codable {
    let id: UUID = UUID()
    let keywordName: String            // 키워드 이름
    var archivedSections: [SectionCard] // 선택한 섹션만 저장
    var savedAt: Date = Date()         // 저장 시각
}
