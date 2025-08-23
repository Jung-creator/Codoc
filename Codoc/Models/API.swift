//
//  API.swift
//  Codoc
//
//  Created by ellllly on 8/23/25.
//

import Foundation

// API 요청/응답 모델들
struct SolarAPIRequest: Codable {
    let messages: [Message]
    let model: String
    let temperature: Double
    let maxTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case messages
        case model
        case temperature
        case maxTokens = "max_tokens"
    }
}

struct Message: Codable {
    let role: String
    let content: String
}

// 수정된 SolarAPIResponse - content를 Codable로 직접 정의
struct SolarAPIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: ChoiceMessage
}

struct ChoiceMessage: Codable {
    let role: String
    let content: String // 기존 DocsSummary.swift 파일의 구조체 사용
}

