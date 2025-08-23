import SwiftUI

/**
 * 메인 화면 - 키워드 버튼들을 그리드 형태로 표시
 * 
 * 주요 기능:
 * - Swift 관련 키워드 버튼들을 20개 정도 표시
 * - 아카이빙된 키워드는 색상으로 구분
 * - 키워드 클릭 시 DocsSummaryView로 네비게이션
 * - 스크롤 가능한 그리드 레이아웃
 */
struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var navigationPath: [NavigationPath] = []
    @State private var selectedTab = 0
    
    var body: some View {
        Text("hello")
    }
}
