import SwiftUI

struct ArchiveListView: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📚 아카이빙")
                .font(.title)
                .fontWeight(.bold)
            
            Text("저장된 키워드 목록")
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 10) {
                Text("Binding")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        navigationPath.append(AppNavigationPath.archiveDetail(keyword: "Binding"))
                    }
                
                Text("State")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        navigationPath.append(AppNavigationPath.archiveDetail(keyword: "State"))
                    }
                
                Text("View")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        navigationPath.append(AppNavigationPath.archiveDetail(keyword: "View"))
                    }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("아카이빙")
    }
}
