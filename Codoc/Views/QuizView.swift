import SwiftUI

struct QuizView: View {
    let keyword: String
    let quiz: Quiz
    @Binding var navigationPath: NavigationPath
    
    @State private var selectedOption: String?
    @State private var isSubmitted = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.yellow.opacity(0), .yellow.opacity(0.15)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                    .frame(height: 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    // 퀴즈 제목
                    Text("퀴즈를 맞춰보세요")
                        .font(FontStyle.medium2.font)
                        .foregroundStyle(.captionGray)
                        .padding(.bottom, -8)
                    
                    
                    // 문제 설명
                    Text(quiz.question)
                        .font(FontStyle.bold3.font)
                        .lineSpacing(FontStyle.bold3.lineSpacing)
                        .foregroundStyle(.textGray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(8)
                
                
                
                // 코드 블록
                QuizCodeBlock(codeContent: quiz.codeExample)
                
                // 옵션 버튼들 (2x2 그리드)
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(["A", "B", "C", "D"], id: \.self) { option in
                        QuizOptionButton(
                            option: option,
                            isSelected: selectedOption == option
                        ) {
                            selectedOption = option
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                
                // 제출 버튼
                QuizSubmitButton(isEnabled: selectedOption != nil) {
                    submitQuiz()
                }
                
                Spacer()
                    .frame(height: 24)
            }
            .padding(.horizontal, DesignSystem.horizontalPadding)
        }
        //        .navigationTitle(keyword)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func submitQuiz() {
        guard let selectedOption = selectedOption else { return }
        
        // 정답 확인
        let correctAnswer = quiz.answer.location
        let index = correctAnswer.index(correctAnswer.startIndex, offsetBy: 0)
        let secondChar = correctAnswer[index]
        let secondCharAsString = String(secondChar).uppercased()
        let isCorrect = selectedOption == secondCharAsString
        
        
        
        // 결과 화면으로 이동
        navigationPath.append(AppNavigationPath.quizResult(keyword: keyword, quiz: quiz, isCorrect: isCorrect))
    }
}

#Preview {
    NavigationStack {
        QuizView(
            keyword: "MainActor",
            quiz: Quiz(
                question: "어느 부분에 [MainActor]를 넣어야하는가?",
                description: "MainActor 사용법에 대한 퀴즈입니다.",
                codeExample: """
                class NetworkManager: ObservableObject {
                    @Published var data: String = ""
                    
                    func fetchData() {
                        // 네트워크 요청
                        DispatchQueue.global().async {
                            // 백그라운드에서 데이터 가져오기
                            let result = "새로운 데이터"
                            
                            DispatchQueue.main.async {
                                self.data = result
                            }
                        }
                    }
                }
                """,
                options: ["A", "B", "C", "D"],
                answer: Answer(
                    location: "(a)",
                    reason: "MainActor를 클래스 선언부에 적용하면 모든 메서드가 메인 스레드에서 실행됩니다."
                )
            ),
            navigationPath: .constant(NavigationPath())
        )
    }
}
