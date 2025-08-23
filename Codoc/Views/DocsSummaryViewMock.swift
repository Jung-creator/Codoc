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
            DocsSummaryCard(
                title: "전체 개요",
                content: "SwiftUI에서 UI 관련 코드는 항상 ​메인 스레드​에서 실행되어야 합니다. MainActor는 이 규칙을 강제하는 ​글로벌 액터​(Global Actor)로, UI 업데이트와 관련된 코드와 데이터를 메인 스레드에 고립시킵니다")
            NaviButton(title: "퀴즈 풀기") {
                navigationPath.append(AppNavigationPath.quiz(keyword: keyword))
            }

            Spacer()
        }
        .padding(.horizontal, DesignSystem.horizontalPadding)

        .navigationTitle(keyword)
    }
}

#Preview {
    DocsSummaryViewMock(keyword: "MainActor", navigationPath: .constant(NavigationPath()))
}
