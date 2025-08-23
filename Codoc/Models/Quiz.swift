import Foundation

struct Quiz: Identifiable, Codable {
    let id: UUID = UUID()
    let question: String               // 퀴즈 문제 (문자열/코드 스니펫 포함)
    let options: [String]              // 선택지
    let correctAnswer: String          // 정답
}
