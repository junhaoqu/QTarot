import SwiftUI

struct ContentView: View {
    @State private var showingQuestionInput = false
    @State private var question = ""
    @State private var selectedMode: ReadingMode = .randomReading
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("QTarot")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 25) {
                    // 问题输入按钮
                    Button {
                        showingQuestionInput = true
                    } label: {
                        Image("question_bg")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gold, lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.3), radius: 10)
                    }
                    .sheet(isPresented: $showingQuestionInput) {
                        QuestionInputView(question: $question)
                            .presentationDetents([.medium])
                    }
                    
                    // Start with a Card 按钮
                    NavigationLink {
                        TarotCardGridView(mode: .randomReading)
                    } label: {
                        MenuButton(title: "Start with a Card", 
                                 subtitle: "Pick a card for general guidance",
                                 systemImage: "questionmark.app.fill")
                    }
                    
                    // Ask a Question 按钮 - 使用 NavigationLink 而不是 sheet
                    NavigationLink {
                        QuestionInputView(question: $question)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        MenuButton(title: "Ask a Question", 
                                 subtitle: "Get guidance for your specific question",
                                 systemImage: "questionmark.circle")
                    }
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
}

struct MenuButton: View {
    let title: String
    let subtitle: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .font(.title)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
