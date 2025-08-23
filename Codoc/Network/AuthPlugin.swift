//
//  AuthPlugin.swift
//  Codoc
//
//  Created by ellllly on 8/23/25.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    let apiKey: String

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = request
        // Bearer 헤더 주입
        req.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return req
    }
}
