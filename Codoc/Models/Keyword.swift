import Foundation

struct Keyword: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String                   // 키워드 이름, ex) "Binding"
    var isArchived: Bool = false       // 아카이빙 여부
    var lastUpdated: Date?             // 마지막 API 호출 시각
    var docs: DocsSummary?             // 해당 키워드 Docs 요약
}
