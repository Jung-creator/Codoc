import Foundation
import Moya

enum NotionAPI {
    case createPage(parent: String, title: String, content: String)
    case searchDatabase(query: String)
}

extension NotionAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.notion.com/v1")! }
    
    var path: String {
        switch self {
        case .createPage: return "/pages"
        case .searchDatabase: return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPage: return .post
        case .searchDatabase: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createPage(let parent, _, let content):
            let safeContent = content.count > 1900 ? String(content.prefix(1900)) + "\n\n[텍스트가 잘렸습니다. 전체 내용은 앱에서 확인하세요.]" : content
            
            let body: [String: Any] = [
                "parent": ["database_id": parent],
                "properties": [
                    // title 속성이 없다면 빈 properties 사용
                ],
                "children": [
                    [
                        "object": "block",
                        "type": "paragraph",
                        "paragraph": [
                            "rich_text": [
                                ["text": ["content": safeContent]]
                            ]
                        ]
                    ]
                ]
            ]
            
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
            
        case .searchDatabase(let query):
            let body: [String: Any] = [
                "query": query,
                "filter": [
                    "value": "database",
                    "property": "object"
                ]
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        // NotionService에서 직접 apiKey 프로퍼티에 접근
        let apiKey = NotionService.shared.apiKey
        
        return [
            "Authorization": "Bearer \(apiKey)",
            "Notion-Version": "2022-06-28",
            "Content-Type": "application/json"
        ]
    }
    
    var sampleData: Data { Data() }
}
