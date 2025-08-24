import SwiftUI

struct QuizResultView: View {
    let keyword: String
    let quiz: Quiz
    let isCorrect: Bool
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(isCorrect ? "정답입니다" : "오답입니다")
                .font(FontStyle.bold5.font)
                .foregroundStyle(.textGray)
            
            Text(quiz.answer.location)
                .font(FontStyle.bold2.font)
                .foregroundStyle(.captionGray)
            Spacer()
                .frame(height: 16)
            Text(quiz.answer.reason)
                .font(FontStyle.regular3.font)
                .lineSpacing(FontStyle.regular3.lineSpacing)
            Spacer()
                .frame(height: 16)
            
            if isCorrect {
                HStack {
                    Button(
                        action: {
                            navigationPath.removeLast(navigationPath.count)
                        }
                    ) {
                        HStack(spacing: 8) {
                            Text("홈으로 가기")
                                .font(FontStyle.bold3.font)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blueMain.opacity(0.5))
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(
                        action: {
                            navigationPath.append(AppNavigationPath.sectionSelection(keyword: keyword))
                        }
                    ) {
                        HStack(spacing: 8) {
                            Text("아카이빙 하기")
                                .font(FontStyle.bold3.font)
                                .foregroundStyle(.white)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blueMain)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } else {
                Button(
                    action: {
                        navigationPath.removeLast()
                    }
                ) {
                    HStack(spacing: 8) {
                        Text("다시 풀기")
                            .font(FontStyle.bold3.font)
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blueMain)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("퀴즈 결과")
    }
}
