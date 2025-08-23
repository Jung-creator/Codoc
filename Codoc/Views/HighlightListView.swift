import SwiftUI

struct HighlightListView: View {
    let keyword: String
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📋 \(keyword) 섹션 선택")
                .font(.title)
                .fontWeight(.bold)
            
            Text("아카이빙할 섹션을 선택하세요")
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
                
                Text("타입 정보")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Button("아카이빙하기") {
                navigationPath.append(AppNavigationPath.archiveDetail(keyword: keyword))
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("취소") {
                navigationPath.removeLast()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("섹션 선택")
    }
}
