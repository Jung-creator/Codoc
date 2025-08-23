import SwiftUI

struct QuizView: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text("❓ \(keyword) 퀴즈")
                .font(.title)
                .fontWeight(.bold)
            
            Text("여기에 퀴즈 문제가 표시됩니다")
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Button("정답 제출") {
                navigationPath.append(AppNavigationPath.quizResult(keyword: keyword, isCorrect: true))
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("오답 제출") {
                navigationPath.append(AppNavigationPath.quizResult(keyword: keyword, isCorrect: false))
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("퀴즈")
    }
}
