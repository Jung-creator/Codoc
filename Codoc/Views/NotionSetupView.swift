import SwiftUI

struct NotionSetupView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var notionService = NotionService.shared
    @State private var apiKey = ""
    @State private var databaseId = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("노션 설정") {
                    TextField("API 키", text: $apiKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("데이터베이스 ID", text: $databaseId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    Button("저장") {
                        notionService.saveCredentials(apiKey: apiKey, databaseId: databaseId)
                        dismiss()
                    }
                    .disabled(apiKey.isEmpty || databaseId.isEmpty)
                }
            }
            .navigationTitle("노션 설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
        }
    }
}
