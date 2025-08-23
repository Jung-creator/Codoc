import Foundation

enum AppNavigationPath: Hashable {
    case docsSummary(keyword: String)
    case quiz(keyword: String, quiz: Quiz)
    case quizResult(keyword: String, isCorrect: Bool)
    case sectionSelection(keyword: String)
    case archiveDetail(keyword: String)
}
