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
            apiKey: ""
        ))
    }
    
    var body: some View {
        Group {
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
                ZStack {
                    LinearGradient(
                        colors: [.yellow.opacity(0), .yellow.opacity(0.15)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            Spacer()
                                .frame(height: 24)
                            HStack {
                                Image("target")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                Text(keyword)
                                    .font(FontStyle.bold5.font)
                                    .foregroundStyle(.textGray)
                                Spacer()
                            }
                            
                            // 문서 요약 카드 컴포넌트 (HighlightText 사용)
                            DocsSummaryHighlightCard(
                                title: "전체 개요",
                                highlightText: summary.overview)
                            
                            CodeBlock(content: summary.codeSnippet)
                            
                            HStack {
                                DocsSummaryHighlightHalfCard(title: "", highlightText: summary.features[0])
                                Spacer()
                                DocsSummaryHighlightHalfCard(title: "", highlightText: summary.features[1])
                            }
                            
                            DocsSummaryHighlightCard(
                                title: "주의 사항",
                                highlightText: summary.caution,
                                isDocs: false)
                            
                            DocsSummaryChipCard(title: "연관 키워드", keywords: summary.relatedKeywords)
                            
                            DocsSummaryHighlightCard(
                                title: "AI 전체 요약",
                                highlightText: summary.aiSummary,
                                isDocs: false)
                            
                            NaviButton(title: "퀴즈 풀기") {
                                navigationPath.append(AppNavigationPath.quiz(keyword: keyword, quiz: summary.quiz))
                            }
                            .padding(.top)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, DesignSystem.horizontalPadding)
                }
                
            } else {
                // 초기 상태 또는 데이터가 없는 경우
                VStack {
                    ProgressView("문서 요약을 준비 중...")
                        .padding()
                }
            }
        }
        .navigationTitle(keyword)
        .onAppear {
            // onAppear를 최상위 레벨로 이동
            if viewModel.docsSummary == nil && !viewModel.isLoading {
                viewModel.fetchDocsSummary(for: keyword)
            }
        }
    }
}
