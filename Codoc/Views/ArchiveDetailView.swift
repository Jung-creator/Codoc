import SwiftUI

struct ArchiveDetailView: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    @StateObject private var notionService = NotionService.shared
    @State private var showingNotionAlert = false
    @State private var notionAlertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("�� \(keyword) 아카이빙")
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // 노션 아이콘 버튼
                Button {
                    saveToNotion()
                } label: {
                    Image(systemName: "note.text")
                        .foregroundColor(.blue)
                }
            }
        }
        .alert("노션 저장", isPresented: $showingNotionAlert) {
            Button("확인") { }
        } message: {
            Text(notionAlertMessage)
        }
    }
    
    // 노션에 저장하는 기능
    private func saveToNotion() {
        // 아카이빙 정보 생성 (실제로는 저장된 데이터를 사용)
        let archiveInfo = """
        �� 개요: \(keyword)에 대한 개요 정보
        💻 예시 코드: \(keyword) 사용 예시
        ⭐ 주요 특징: \(keyword)의 주요 특징들
        ⚠️ 주의사항: \(keyword) 사용 시 주의사항
        �� 연관 키워드: \(keyword)와 관련된 키워드들
        """
        
        // 노션에 저장 (키워드를 제목으로 사용)
        notionService.saveToNotion(keyword: keyword, archiveInfo: archiveInfo)
        
        // 알림 표시
        notionAlertMessage = "노션 페이지 내용이 클립보드에 복사되었습니다!\n\n노션에서 새 페이지를 열고 붙여넣기(Cmd+V)하여 사용하세요.\n\n페이지 제목: \(keyword)"
        showingNotionAlert = true
    }
}
