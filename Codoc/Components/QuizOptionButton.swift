import SwiftUI

struct QuizOptionButton: View {
    let option: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(option)
                    .font(FontStyle.bold4.font)
                    .foregroundStyle(.blueMain)
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundStyle(.blueMain)
                    .font(.system(size: 20))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.blueMain.opacity(0.3), lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
//                            .fill(isSelected ? .blueMain.opacity(0.05) : .clear)
                            .fill(isSelected ? .blueMain.opacity(0.3) :.white.opacity(0.5))
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 12) {
        QuizOptionButton(option: "A", isSelected: false) {}
        QuizOptionButton(option: "B", isSelected: true) {}
        QuizOptionButton(option: "C", isSelected: false) {}
        QuizOptionButton(option: "D", isSelected: false) {}
    }
    .padding()
}
