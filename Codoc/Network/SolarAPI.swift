//
//  SolarAPI.swift
//  Codoc
//
//  Created by ellllly on 8/23/25.
//

import Moya
import Foundation

enum SolarAPI {
    case chatCompletions(messages: [Message]) // API 키 제거
}

extension SolarAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.upstage.ai/v1")!
    }
    
    var path: String {
        switch self {
        case .chatCompletions:
            return "/chat/completions"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .chatCompletions:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .chatCompletions(let messages):
            let body = [
                "messages": messages.map { [
                    "role": $0.role,
                    "content": $0.content
                ] },
                "model": "solar-pro2"
                // temperature와 maxTokens는 선택적
            ] as [String : Any]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
            // Authorization은 AuthPlugin에서 처리
        ]
    }
}
