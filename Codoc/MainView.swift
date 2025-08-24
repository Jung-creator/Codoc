import SwiftUI

struct MainView: View {
    @State private var navigationPath = NavigationPath()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 메인 탭
            NavigationStack(path: $navigationPath) {
                VStack(spacing: 20) {
                    Text("🚀 Codoc")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Swift 키워드 학습")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 15) {
                        ForEach(["Binding", "State", "View", "ObservableObject", "Published", "Environment"], id: \.self) { keyword in
                            Button(keyword) {
                                navigationPath.append(AppNavigationPath.docsSummary(keyword: keyword))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("메인")
                .navigationDestination(for: AppNavigationPath.self) { path in
                    switch path {
                    case .docsSummary(let keyword):
                        DocsSummaryView(keyword: keyword, navigationPath: $navigationPath)
                    case .quiz(let keyword, let quiz):
                        QuizView(keyword: keyword, quiz: quiz, navigationPath: $navigationPath)
                    case .quizResult(let keyword, let quiz, let isCorrect):
                        QuizResultView(keyword: keyword, quiz: quiz, isCorrect: isCorrect, navigationPath: $navigationPath)
                    case .sectionSelection(let keyword):
                        HighlightListView(keyword: keyword, navigationPath: $navigationPath)
                    case .archiveDetail(let keyword):
                        ArchiveDetailView(keyword: keyword, navigationPath: $navigationPath)
                    }
                }
            }
            .tabItem {
                Image(systemName: "house")
                Text("메인")
            }
            .tag(0)
            
            // 아카이빙 탭
            NavigationStack(path: $navigationPath) {
                ArchiveListView(navigationPath: $navigationPath)
                    .navigationDestination(for: AppNavigationPath.self) { path in
                        switch path {
                        case .archiveDetail(let keyword):
                            ArchiveDetailView(keyword: keyword, navigationPath: $navigationPath)
                        default:
                            EmptyView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "bookmark")
                Text("아카이빙")
            }
            .tag(1)
        }
    }
}

//// 아카이빙 디테일 뷰 (임시)
//struct ArchiveDetailView: View {
//    let keyword: String
//    @Binding var navigationPath: NavigationPath
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("📚 \(keyword) 아카이빙")
//                .font(.title)
//                .fontWeight(.bold)
//            
//            Text("저장된 섹션들")
//                .font(.headline)
//                .foregroundColor(.secondary)
//            
//            VStack(spacing: 10) {
//                Text("개요")
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue.opacity(0.1))
//                    .cornerRadius(8)
//                
//                Text("예시 코드")
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.green.opacity(0.1))
//                    .cornerRadius(8)
//            }
//            
//            Button("삭제") {
//                navigationPath.removeLast()
//            }
//            .padding()
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle(keyword)
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                // 노션 아이콘 버튼
//                Button {
//                    openInNotion()
//                } label: {
//                    Image(systemName: "note.text")
//                        .foregroundColor(.blue)
//                }
//            }
//        }
//    }
//    // 노션으로 이동하는 함수
//    private func openInNotion() {
//        // 노션 웹사이트로 이동
//        if let url = URL(string: "https://www.notion.so") {
//            UIApplication.shared.open(url)
//        }
//    }
//}

#Preview {
    MainView()
}
