//
//  DocsSummaryViewModel.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//

import Foundation
import Moya
import Combine

@MainActor
class DocsSummaryViewModel: ObservableObject {
    @Published var docsSummary: DocsSummary?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let provider: MoyaProvider<SolarAPI>
    private var cancellables = Set<AnyCancellable>()
    private let apiKey: String
    
    init(apiKey: String, stub: Bool = false) {
        self.apiKey = apiKey

        let plugins: [PluginType] = [
            AuthPlugin(apiKey: apiKey),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 디버깅에 유용
        ]
        self.provider = stub
        ? MoyaProvider<SolarAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: plugins)
        : MoyaProvider<SolarAPI>(plugins: plugins)
    }
    
    func fetchDocsSummary(for keyword: String) {
        isLoading = true
        errorMessage = nil
        
        let prompt = """
        너는 Swift 학습자를 위한 퀴즈 생성기 역할을 한다. 입력으로 주어지는 Swift 키워드에 대해, Apple 공식 문서(https://developer.apple.com/documentation/Swift 또는 해당 키워드의 공식 문서)를 기반으로 설명을 작성하고, 
        학습자가 맥락 속에서 이해할 수 있도록 코드 시나리오와 퀴즈를 만든다. 
        
        출력은 반드시 아래 내용과 제약을 따르며, JSON 형태로 응답해주세요.

        [출력 내용]
        1) 키워드 요약 (공식 문서 기반)
        - 전체 개요(150자 이내), 강조 단어 2개 리스트 포함
        - 예시 코드
        - 주요 특징 (2개 이내 불릿, 각 불릿은 55자 이내), 핵심 강조 단어 2~3개 리스트 포함    - 주의사항 (150자 이내) , 핵심  강조 단어 2~3개 리스트 포함
        - 연관 키워드
        - AI 모델인 Solar의 요약, 핵심 강조 단어 2~3개 리스트 포함

        2) 총 1개의 퀴즈 
        - "어느 부분에 [키워드]를 넣어야 하는가?" 형식
        - 퀴즈는 다음 순서로 제시한다:
            a. 문제 설명(한두 문장)
            b. 코드 예시 (컴파일 가능한 Swift 5.9+ 수준, 40줄 이내, 빈칸 금지, 퀴즈 정답이 되는 위치에 [키워드]가 없어야 한다.) 
            - 코드에는 (a)부터 (d)까지 무조건 총 4개가 표시된다. 
            c. 정답: [키워드를 넣어야 하는 정확한 위치(선언부/속성/메서드/라인 등)],  (a) ~ (d) 중 하나와 그 이유
            d. 정답 형식: "A/B/C/D 중 하나 - 정확한 위치"

        [제약/스타일]
        - 모든 설명은 한국어로 한다.
        - 코드 예시는 실제로 사용할 법한 간단한 앱/모듈 맥락을 사용한다(SwiftUI/Concurrency 등).
        - 퀴즈는 문제 모두 "어느 부분에 [키워드]를 넣어야 하는지"를 묻는 동일한 형식을 유지한다.
        - 퀴즈의 난이도는 높은 편이다.
        - 정답에는 모범 위치를 구체적으로 명시한다(예: "클래스 선언부 앞에 @MainActor", "프로퍼티에 @State").
        - 마크다운 형식을 추가하면 안된다.
        - 응답은 꼭 JSON 형식으로 해준다.
        
        다음 형식으로 응답을 제공해주세요:
        {
            "keywordSummary": {
                "overview": {
                    "content": "키워드에 대한 간단한 설명",
                    "highlights": ["중요한", "단어들"]
                },
                "codeSnippet": "간단한 사용 예시 코드",
                "features": [
                    {
                        "content": "키워드의 주요 특징1",
                        "highlights": ["중요한", "단어들"]
                    },
                    {
                        "content": "키워드의 주요 특징2",
                        "highlights": ["중요한", "단어들"]
                    }
                ],
                "caution": {
                    "content": "주의사항",
                    "highlights": ["주의", "사항"]
                },
                "relatedKeywords": ["연관된", "키워드들"],
                "aiSummary": {
                    "content": "전체 요약",
                    "highlights": ["핵심", "포인트"]
                }
            },
            "quiz": {
                "question": "어느 부분에 [키워드]를 넣어야 하는가?",
                "description": "문제 설명",
                "codeExample": "코드 예시",
                "options": ["A", "B", "C", "D"],
                "answer": {
                    "location": "키워드를 넣어야 하는 정확한 위치",
                    "reason": "정답에 대한 이유"
                }
            }
        }

        [입력]
        키워드: \(keyword)
        """
        
        let request = SolarAPIRequest(
            messages: [Message(role: "user", content: prompt)],
            model: "solar-pro2",
            temperature: 0.7,
            maxTokens: 2000
        )
        
        // API 키를 직접 전달하지 않음
        let solarRequest = SolarAPI.chatCompletions(messages: [
            Message(role: "user", content: prompt)
        ])
        provider.request(solarRequest) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let response):
                    do {
                        let apiResponse = try response.map(SolarAPIResponse.self)
                        let content = apiResponse.choices.first?.message.content ?? ""
                        
                        // 디버깅을 위한 로그 추가
                        print("=== Solar API 응답 내용 ===")
                        print(content)
                        print("=== 응답 끝 ===")
                        
                        // JSON 본문 추출 시도 (코드펜스/앞뒤 설명 제거 대응)
                        if let jsonString = self?.extractJSON(from: content),
                           let data = jsonString.data(using: .utf8) {
                            do {
                                let summary = try JSONDecoder().decode(DocsSummary.self, from: data)
                                self?.docsSummary = summary
                                print("✅ JSON 파싱 성공!")
                                print("개요: \(summary.overview.content)")
                                print("AI 요약: \(summary.aiSummary.content)")
                                print("퀴즈: \(summary.quiz.question)")
                            } catch {
                                self?.dumpDecoding(error, jsonString: jsonString)   // 상세 디버깅
                                self?.createFallbackSummary(from: content, keyword: keyword)
                            }
                        } else {
                            print("❌ JSON 본문 추출 실패")
                            self?.createFallbackSummary(from: content, keyword: keyword)
                        }
                    } catch {
                        print("❌ API 응답 파싱 에러: \(error)")
                        self?.errorMessage = "응답 처리 실패: \(error.localizedDescription)"
                    }
                    
                case .failure(let error):
                    print("❌ API 요청 실패: \(error)")
                    self?.errorMessage = "API 요청 실패: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // JSON 파싱 실패 시 fallback으로 사용할 요약 생성
    private func createFallbackSummary(from content: String, keyword: String) {
        let fallbackSummary = DocsSummary(
            keywordSummary: KeywordSummary(
                overview: HighlightText(
                    content: "Solar AI가 생성한 \(keyword)에 대한 요약 정보입니다.",
                    highlights: [keyword, "요약"]
                ),
                codeSnippet: "// 예시 코드가 아직 생성되지 않았습니다.",
                features: [
                    HighlightText(
                        content: "첫번째 특징",
                        highlights: ["첫번째", "특징"]
                    ),
                    HighlightText(
                        content: "두번째 특징",
                        highlights: ["두번째", "특징"]
                    )
                ],
                caution: HighlightText(
                    content: "이 키워드 사용 시 주의사항이 아직 생성되지 않았습니다.",
                    highlights: ["주의사항"]
                ),
                relatedKeywords: ["관련 키워드가 아직 생성되지 않았습니다."],
                aiSummary: HighlightText(
                    content: content,
                    highlights: [keyword, "AI", "생성"]
                )
            ),
            quiz: Quiz(
                question: "어느 부분에 [\(keyword)]를 넣어야 하는가?",
                description: "문제 설명이 아직 생성되지 않았습니다.",
                codeExample: "// 코드 예시가 아직 생성되지 않았습니다.",
                options: ["(a)", "(b)", "(c)", "(d)"],
                answer: Answer(
                    location: "정답 위치가 아직 생성되지 않았습니다.",
                    reason: "정답 이유가 아직 생성되지 않았습니다."
                )
            )
        )
        
        self.docsSummary = fallbackSummary
    }
    private func extractJSON(from raw: String) -> String? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)

        // ``` ... ``` 코드펜스 블록 우선 추출
        if let start = trimmed.range(of: "```"),
           let end = trimmed.range(of: "```", range: start.upperBound..<trimmed.endIndex) {
            var body = String(trimmed[start.upperBound..<end.lowerBound])

            // 첫 줄에 "json" 같은 라벨이 붙은 경우 제거
            if let nl = body.firstIndex(of: "\n") {
                let maybeLabel = body[..<nl].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                if ["json", "swift"].contains(maybeLabel) {
                    body = String(body[body.index(after: nl)...])
                }
            }
            let candidate = body.trimmingCharacters(in: .whitespacesAndNewlines)
            return candidate.hasPrefix("{") ? candidate : nil
        }

        // 코드펜스가 없고 곧바로 { 로 시작하는 경우
        if trimmed.hasPrefix("{") { return trimmed }

        return nil
    }

    // DecodingError 상세 로그
    private func dumpDecoding(_ error: Error, jsonString: String) {
        if case let e as DecodingError = error {
            switch e {
            case let .typeMismatch(_, ctx),
                 let .valueNotFound(_, ctx),
                 let .keyNotFound(_, ctx),
                 let .dataCorrupted(ctx):
                print("❌ DecodingError:", e)
                print("   -> Context:", ctx.debugDescription)
                print("   -> CodingPath:", ctx.codingPath.map { $0.stringValue }.joined(separator: " → "))

            @unknown default:
                print("❌ DecodingError(unknown):", e)
            }
        } else {
            print("❌ Error:", error.localizedDescription)
        }

        print("""
        ---- JSON preview ----
        \(jsonString.prefix(400))
        ----------------------
        """)
    }

}
//
//  DocsSummaryViewModel.swift
//  Codoc
//
//  Created by Choi Jung In on 8/24/25.
//
