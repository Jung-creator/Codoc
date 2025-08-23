import SwiftUI

struct QuizSubmitButton: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text("결과 보기")
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
                    .fill(isEnabled ? .blueMain : .blueMain.opacity(0.8))
            )
        }
        .disabled(!isEnabled)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        QuizSubmitButton(isEnabled: true) {}
        QuizSubmitButton(isEnabled: false) {}
    }
    .padding()
}
