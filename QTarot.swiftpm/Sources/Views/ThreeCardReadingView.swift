import SwiftUI

struct ThreeCardReadingView: View {
    @Environment(\.dismiss) private var dismiss
    
    let cards: [TarotCard]
    let mode: ReadingMode
    var question: String
    
    @State private var aiReading: String = ""
    @State private var isLoading = false
    @State private var error: String?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景
                Image("table")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.8))
                
                ScrollView {
                    VStack(spacing: 30) {
                        Text("Your Question: \(question)")
                            .font(.custom("Papyrus", size: 20))
                            .fontWeight(.heavy)  // 使用最粗的字重
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
                        Text("Your Reading")
                            .font(.custom("Papyrus", size: 20))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        // 时间轴标题 (Past, Present, Future)
                        HStack(spacing: 30) {
                            ForEach(["Past", "Present", "Future"], id: \.self) { title in
                                Text(title)
                                    .font(.title2)
                                    .foregroundColor(.customGold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // 卡片展示
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(Array(zip(cards.indices, cards)), id: \.0) { index, card in
                                VStack(spacing: 15) {
                                    Image(card.imageName)
                                        .resizable()
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .frame(maxWidth: geometry.size.width * 0.25)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.5), radius: 10)
                                    
                                    Text(card.name)
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    
                                    Text(card.meaning)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white.opacity(0.9))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 10)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // AI Interpretation area — only if user actually asked a question
                        if mode.question != nil {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("AI Interpretation")
                                    .font(.title2)
                                    .foregroundColor(.customGold)
                                
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else if let error = error {
                                    Text(error)
                                        .foregroundColor(.red)
                                } else if !aiReading.isEmpty {
                                    // Show the final AI reading text
                                    Text(aiReading)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                } else {
                                    Text("Generating your AI reading...")
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 40)
                    }
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
        // When the view appears, generate AI reading if there's a question
        .task {
            if mode.question != nil {
                await generateAIReading(question: question, cards: cards)
            }
        }
    }
    
    // MARK: - AI Reading Logic
    private func generateAIReading(question: String, cards: [TarotCard]) async {
        isLoading = true
        error = nil
        
        do {
            // Call the OpenAI service to generate the reading
            aiReading = try await OpenAIService.shared.generateTarotReading(
                cards: cards,
                question: question
            )
        } catch {
            self.error = "Failed to generate AI reading: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
