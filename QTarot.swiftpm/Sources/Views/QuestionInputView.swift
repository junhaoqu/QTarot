import SwiftUI

struct QuestionInputView: View {
    @State private var question: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("What would you like to know?")
                .font(.headline)
            
            TextEditor(text: $question)
                .frame(height: 100)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            NavigationLink {
                TarotCardGridView(mode: .questionReading(question))
            } label: {
                Text("Continue to Cards")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(question.isEmpty)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Ask Your Question")
    }
}

#Preview {
    NavigationStack {
        QuestionInputView()
    }
} 