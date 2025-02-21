import SwiftUI


struct QuestionFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var question: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image
                Image("question_bg")
                    .resizable()
                    .scaledToFill()
                   
                    .overlay(Color.black.opacity(0.7))
                    .ignoresSafeArea()
                
                ScrollView {
                    // Give the content a minimum height so on a tall iPad screen
                    // it won't all stick to the top.
                    VStack(spacing: 40) {

                        Text("Hint")
                        .font(.custom("Papyrus", size: 40))
                        .fontWeight(.heavy)  // 使用最粗的字重
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 2)  // 增强阴影
                        .overlay(  // 添加描边效果使文字更突出
                            Text("Hint")
                                .font(.custom("Papyrus", size: 32))
                                .fontWeight(.heavy)
                                .foregroundColor(.black.opacity(0.3))
                                .offset(x: 1, y: 1)
                        )
                        
                        // 1) Prompt text
                        Text("The cards respond to your energy, so stay focused and relaxed. A cluttered mind can lead to unclear readings. Take a deep breath, set your intention, and keep your thoughts centered.")
                            .font(.custom("Papyrus", size:25))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .fontWeight(.heavy)
                        
                        // 2) "Your Question" input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your Question:")
                                .font(.system(size: 22, weight: .regular))
                                .foregroundColor(.white.opacity(0.9))
                            
                            TextField("Enter your question...", text: $question, axis: .vertical)
                                .textFieldStyle(.plain)
                                .lineLimit(3...6)
                                .padding()
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.black.opacity(0.3))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.customGold.opacity(0.7), lineWidth: 2)
                                )
                                
                        }
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 30)
                        
                        // 3) "Shuffle Cards" button
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
                        .padding(.horizontal, 30)
                    }
                    // Add extra top/bottom padding for iPad
                    .padding(.top, 80)
                    .padding(.bottom, 60)
                    // Make sure the VStack is at least as tall as the screen
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("Back")
                        .foregroundColor(.white)
                }
            }
        }
        .onDisappear {
            // 当视图消失时清空问题
            question = ""
        }
    }
}

// For preview
#Preview {
    NavigationStack {
        QuestionFormView(question: .constant(""))
    }
}