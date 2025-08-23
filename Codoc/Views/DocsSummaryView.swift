import SwiftUI

struct DocsSummaryView: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    @StateObject private var viewModel: DocsSummaryViewModel
    
    // 초기화자 추가
    init(keyword: String, navigationPath: Binding<NavigationPath>) {
        self.keyword = keyword
        self._navigationPath = navigationPath
        // API 키를 여기에 직접 입력하거나 환경변수에서 가져오기
        self._viewModel = StateObject(wrappedValue: DocsSummaryViewModel(
            apiKey: "up_t0pjQtQK1gTSFUDVyX6sUE02HyDHR"
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("📚 \(keyword) 문서 요약")
                    .font(.title)
                    .fontWeight(.bold)
                
                if viewModel.isLoading {
                    ProgressView("문서 요약 중...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(errorMessage)
                            .foregroundColor(.red)
                        Button("다시 시도") {
                            viewModel.fetchDocsSummary(for: keyword)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                } else if let summary = viewModel.docsSummary {
                    // 개요 섹션
                    
                    SummarySection(
                        title: "📖 개요",
                        content: summary.overview.content,
                        highlights: summary.overview.highlights
                    )
                    
                    
                    // 예시 코드 섹션
                    
                    SummarySection(
                        title: "💻 예시 코드",
                        content: summary.codeSnippet,
                        highlights: []
                    )
                    

                    // 주요 특징 섹션들
                    let feats = summary.features
                    if !feats.isEmpty {
                        ForEach(Array(feats.prefix(2)).indices, id: \.self) { i in
                            let f = feats[i]
                            SummarySection(
                                title: "⭐ 주요 특징 \(i + 1)",
                                content: f.content,
                                highlights: f.highlights
                            )
                        }
                    }
                    
                    // 주의사항 섹션
                    
                    SummarySection(
                        title: "⚠️ 주의사항",
                        content: summary.caution.content,
                        highlights: summary.caution.highlights
                    )
                    
                    
                    // 연관 키워드 섹션
                    let relatedKeywords = summary.relatedKeywords
                    if !relatedKeywords.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("🔗 연관 키워드")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                                ForEach(relatedKeywords, id: \.self) { keyword in
                                    Text(keyword)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                    // AI 전체 요약 섹션
                    
                    SummarySection(
                        title: "🤖 AI 전체 요약",
                        content: summary.aiSummary.content,
                        highlights: summary.aiSummary.highlights
                    )
                    
                    
                    // 액션 버튼들
                    HStack(spacing: 15) {
                        Button("퀴즈 풀기") {
                            navigationPath.append(AppNavigationPath.quiz(keyword: keyword))
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("섹션 선택") {
                            navigationPath.append(AppNavigationPath.sectionSelection(keyword: keyword))
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else {
                    Text("문서를 불러오는 중...")
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(keyword)
        .onAppear {
            viewModel.fetchDocsSummary(for: keyword)
        }
    }
}

// 요약 섹션 컴포넌트
struct SummarySection: View {
    let title: String
    let content: String
    let highlights: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(content)
                .font(.body)
                .lineSpacing(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}
