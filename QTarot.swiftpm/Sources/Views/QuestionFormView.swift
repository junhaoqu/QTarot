import SwiftUI

struct QuestionFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var question: String
    
    var body: some View {
        ZStack {
            // 背景图片
            Image("question_bg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(Color.black.opacity(0.7))
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    // 提示文字
                    Text("The cards respond to your energy, so stay focused and relaxed. A cluttered mind can lead to unclear readings. Take a deep breath, set your intention, and keep your thoughts centered.")
                        .font(.custom("Papyrus", size: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 60)
                    
                    // 问题输入框
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Question:")
                            .font(.system(size: 16, weight: .regular)) // **使用常规字体**
                            .foregroundColor(.white.opacity(0.9))
                        
                        TextField("Enter your question...", text: $question, axis: .vertical)
                            .lineLimit(3...6)
                            .padding()
                            .font(.system(size: 18)) // **保持正常字体**
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.black.opacity(0.3)) // **改成黑色半透明**
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.customGold.opacity(0.7), lineWidth: 2) // **增加金色边框**
                            )
                    }
                    .padding(.horizontal, 30)
                        
                    // Shuffle Cards 按钮
                    NavigationLink {
                        DeckShuffleView()
                    } label: {
                        Text("Shuffle Cards")
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.customGold.opacity(0.8))
                            )
                    }
                    .disabled(question.isEmpty)
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            // 当视图消失时清空问题
            question = ""
        }
    }
}

#Preview {
    NavigationStack {
        QuestionFormView(question: .constant(""))
    }
} 


