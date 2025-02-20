import SwiftUI

extension Color {
    static let customGold = Color(red: 232/255, green: 201/255, blue: 130/255)
}

struct QuestionInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var question: String
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // 背景图
            Image("question_bg")
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.2))
                .ignoresSafeArea()
            
            // 中间的“动态光圈”按钮
            VStack {
                Spacer()
                
                NavigationLink(destination: QuestionFormView(question: $question)) {
                    ZStack {
                        ForEach(0..<3) { i in
                            Circle()
                                .stroke(Color.customGold.opacity(0.8), lineWidth: 3)
                                .frame(width: animate ? 220 + CGFloat(i * 40) : 150 + CGFloat(i * 40))
                                .scaleEffect(animate ? 1.5 : 0.7)
                                .shadow(color: Color.customGold.opacity(0.9), radius: 15)
                                .blur(radius: 3)
                                .animation(
                                    .easeInOut(duration: 3.0)
                                        .repeatForever(autoreverses: true)
                                        .delay(Double(i) * 0.3),
                                    value: animate
                                )
                        }
                    }
                }
                .onAppear {
                    animate = true
                }
                
                Spacer()
            }
        }
        // 使用底部工具栏
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.blue, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Maybe Later")
                        .font(.custom("Papyrus", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.customGold.opacity(0.3))
                        )
                }
            }
        }
    }
}

// 预览
#Preview {
    NavigationStack {
        QuestionInputView(question: .constant(""))
    }
}
