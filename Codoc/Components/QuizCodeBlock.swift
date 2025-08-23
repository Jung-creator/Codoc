import SwiftUI

struct QuizCodeBlock: View {
    let codeContent: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(codeContent)
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundStyle(.white)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 300)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.black)
        )
    }
}

#Preview {
    QuizCodeBlock(codeContent: """
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
    """)
    .padding()
}
