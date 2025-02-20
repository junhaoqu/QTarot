import SwiftUI

extension Color {
    static let customGold = Color(red: 232/255, green: 201/255, blue: 130/255)
}

struct QuestionInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var question: String
    @State private var showingQuestionPopup = false
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // 背景图片
            Image("question_bg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(Color.black.opacity(0.2))
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                // 动态光圈按钮
                NavigationLink(destination: QuestionFormView(question: $question)) {
                    ZStack {
                        ForEach(0..<3) { i in
                            Circle()
                                .stroke(Color.customGold.opacity(0.8), lineWidth: 3) // 更粗
                                .frame(width: animate ? 220 + CGFloat(i * 40) : 150 + CGFloat(i * 40)) // 扩展范围
                                .scaleEffect(animate ? 1.5 : 0.7)
                                .shadow(color: Color.customGold.opacity(0.9), radius: 15)
                                .blur(radius: 3)
                                .animation(
                                    .easeInOut(duration: 4.0)
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

                // 固定底部的 "Maybe Later" 按钮
                Button(action: {
                    dismiss()
                }) {
                    Text("Maybe Later")
                        .font(.custom("Papyrus", size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.customGold.opacity(0.3)) // 自定义金色
                        )
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 20) // 让按钮始终保持在底部
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.blue, for: .navigationBar) // 让导航栏背景变蓝
    }
}

#Preview {
    NavigationStack {
        QuestionInputView(question: .constant(""))
    }
}

