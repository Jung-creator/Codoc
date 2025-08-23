import SwiftUI

struct DocsSummaryViewMock: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(keyword)
                .font(FontStyle.bold5.font)
                .foregroundStyle(.textGray)
            
            // 문서 요약 카드 컴포넌트
            VStack(alignment: .leading, spacing: 16) {
                // 제목 부분
                HStack(spacing: 8) {
                    Circle()
                        .fill(.white)
                        .frame(width: 30, height: 30)
                    
                    Text("전체 개요")
                        .font(FontStyle.bold2.font)
                        .foregroundStyle(.blueMain)
                }
                
                // 본문 내용
                Text("SwiftUI에서 UI 관련 코드는 항상 ​메인 스레드​에서 실행되어야 합니다. MainActor는 이 규칙을 강제하는 ​글로벌 액터​(Global Actor)로, UI 업데이트와 관련된 코드와 데이터를 메인 스레드에 고립시킵니다")
                    .font(FontStyle.regular3.font)
                    .lineSpacing(FontStyle.regular3.lineSpacing)
                    .foregroundStyle(.textGray)
                
                // 하단 문구
                Text("Based on the official documentation")
                    .font(FontStyle.regular1.font)
                    .foregroundStyle(.captionGray)
            }
            .padding(20)
            .background(.blueMain.opacity(0.05))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blueMain.opacity(0.5), lineWidth: 1)
            )
            
            
            Button("퀴즈 풀기") {
                navigationPath.append(AppNavigationPath.quiz(keyword: keyword))
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding(.horizontal, DesignSystem.horizontalPadding)

        .navigationTitle(keyword)
    }
}

#Preview {
    DocsSummaryViewMock(keyword: "MainActor", navigationPath: .constant(NavigationPath()))
}
