import Foundation

struct QuizResult: Identifiable, Codable {
    let id: UUID = UUID()
    let quizId: UUID                   // 퀴즈 ID
    let keywordName: String            // 키워드 이름
    let userAnswer: String             // 사용자 답변
    let isCorrect: Bool                // 정답 여부
    let answeredAt: Date = Date()      // 답변 시각
}
