import SwiftUI

struct DocsSummaryView: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📚 \(keyword) 문서 요약")
                .font(.title)
                .fontWeight(.bold)
            
            Text("여기에 문서 요약 내용이 표시됩니다")
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
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
            
            Spacer()
        }
        .padding()
        .navigationTitle(keyword)
    }
}
