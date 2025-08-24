import Foundation
import UIKit

class NotionService: ObservableObject {
    static let shared = NotionService()
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    // 노션 API 키와 데이터베이스 ID를 코드에 직접 설정
    let apiKey = "secret_your_actual_notion_api_key_here"  // private 제거
    let databaseId = "your_database_id_here"  // private 제거
    
    private init() {}
    
    // clearCredentials 메서드 추가
    func clearCredentials() {
        // API 키 초기화 로직
        self.isLoggedIn = false
    }
    
    // saveCredentials 메서드 추가
    func saveCredentials(apiKey: String, databaseId: String) {
        // API 키 저장 로직
        self.isLoggedIn = true
    }
    
    // 노션 새 페이지 생성 (제목 포함)
    func createNewPage(title: String) {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
        let notionNewPageURL = "https://www.notion.so/new?title=\(encodedTitle)"
        
        if let url = URL(string: notionNewPageURL) {
            UIApplication.shared.open(url)
        }
    }
    
    // 노션 페이지 내용을 클립보드에 복사
    func copyContentToClipboard(content: String) {
        UIPasteboard.general.string = content
    }
    
    // 아카이빙 정보를 노션 페이지 내용으로 생성
    func generateNotionContent(keyword: String, archiveInfo: String) -> String {
        var content = "# \(keyword) - Swift 키워드 아카이빙\n\n"
        content += " 생성일: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        content += "## 📚 아카이빙 정보\n\n"
        content += "\(archiveInfo)\n\n"
        content += "---\n"
        content += "📱 Codoc 앱에서 생성됨 | Swift 키워드 학습 아카이빙"
        
        return content
    }
    
    // 노션에 저장 (클립보드 복사 + 새 페이지 생성)
    func saveToNotion(keyword: String, archiveInfo: String) {
        let content = generateNotionContent(keyword: keyword, archiveInfo: archiveInfo)
        copyContentToClipboard(content: content)
        createNewPage(title: keyword)
    }
}