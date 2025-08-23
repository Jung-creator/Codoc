import SwiftUI

struct QuizResultView: View {
    let keyword: String
    let isCorrect: Bool
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isCorrect ? "✅ 정답입니다!" : "❌ 틀렸습니다")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(isCorrect ? .green : .red)
            
            Text("\(keyword) 퀴즈 결과")
                .font(.headline)
            
            if isCorrect {
                Button("섹션 선택하기") {
                    navigationPath.append(AppNavigationPath.sectionSelection(keyword: keyword))
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Button("다시 풀기") {
                    navigationPath.removeLast()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            Button("메인으로 돌아가기") {
                navigationPath.removeLast(navigationPath.count)
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("퀴즈 결과")
    }
}
