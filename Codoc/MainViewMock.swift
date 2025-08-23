import SwiftUI

struct MainViewMock: View {
    @State private var navigationPath = NavigationPath()
    @State private var selectedTab = 0
    
    // 랜덤 색상 배열
    private let randomColors: [Color] = [.blueMain, .yellowMain, .redMain]
    
    // 랜덤 색상 반환 함수
    private func getRandomColor() -> Color {
        randomColors.randomElement() ?? .blueMain
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 메인 탭
            NavigationStack(path: $navigationPath) {
                ZStack {
                    LinearGradient(
                        colors: [.yellow.opacity(0), .yellow.opacity(0.15)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("학습하려는 키워드를 선택하세요")
                            .font(FontStyle.bold5.font)
                            .foregroundStyle(.textGray)
                        Spacer()
                            .frame(height: 16)
                        
                        Text("Apple 공식 문서를 우선 번역 및 정리하고\n부족한 부분은 Solar Pro 2가 채워줘요")
                            .font(FontStyle.regular3.font)
                            .foregroundStyle(.captionGray)
                        Spacer()
                            .frame(height: 72)
                        
                        HStack {
                            ForEach(["Binding", "State", "ObservableObject"], id: \.self) { keyword in
                                KeywordButton(
                                    title: keyword,
                                    borderColor: getRandomColor(),
                                    action: {
                                        navigationPath.append(AppNavigationPath.docsSummary(keyword: keyword))
                                    }
                                )
                            }
                        }
                        HStack {
                            ForEach(["Sendable","EnvironmentObject",  "Actor"], id: \.self) { keyword in
                                KeywordButton(
                                    title: keyword,
                                    borderColor: getRandomColor(),
                                    action: {
                                        navigationPath.append(AppNavigationPath.docsSummary(keyword: keyword))
                                    }
                                )
                            }
                        }
                        HStack {
                            ForEach(["Actor","MainActor", "Task"], id: \.self) { keyword in
                                KeywordButton(
                                    title: keyword,
                                    borderColor: getRandomColor(),
                                    action: {
                                        navigationPath.append(AppNavigationPath.docsSummary(keyword: keyword))
                                    }
                                )
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, DesignSystem.horizontalPadding)
                    .navigationDestination(for: AppNavigationPath.self) { path in
                        switch path {
                        case .docsSummary(let keyword):
                            DocsSummaryView(keyword: keyword, navigationPath: $navigationPath)
                        case .quiz(let keyword):
                            QuizView(keyword: keyword, navigationPath: $navigationPath)
                        case .quizResult(let keyword, let isCorrect):
                            QuizResultView(keyword: keyword, isCorrect: isCorrect, navigationPath: $navigationPath)
                        case .sectionSelection(let keyword):
                            HighlightListView(keyword: keyword, navigationPath: $navigationPath)
                        case .archiveDetail(let keyword):
                            ArchiveDetailViewMock(keyword: keyword, navigationPath: $navigationPath)
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "button.angledbottom.horizontal.right.fill")
            }
            .tag(0)
            
            // 아카이빙 탭
            NavigationStack(path: $navigationPath) {
                ArchiveListView(navigationPath: $navigationPath)
                    .navigationDestination(for: AppNavigationPath.self) { path in
                        switch path {
                        case .archiveDetail(let keyword):
                            ArchiveDetailViewMock(keyword: keyword, navigationPath: $navigationPath)
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "text.justify.left")
            }
            .tag(1)
        }
        .tint(.blueMain)
    }
}

// 아카이빙 디테일 뷰 (임시)
struct ArchiveDetailViewMock: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📚 \(keyword) 아카이빙")
                .font(.title)
                .fontWeight(.bold)
            
            Text("저장된 섹션들")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 10) {
                Text("개요")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                
                Text("예시 코드")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Button("삭제") {
                navigationPath.removeLast()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle(keyword)
    }
}

#Preview {
    MainViewMock()
}
