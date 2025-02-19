import SwiftUI

struct ReadingView: View {
    let card: TarotCard
    let mode: ReadingMode
    @Environment(\.dismiss) private var dismiss
    @State private var interpretation: String = ""
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Using SF Symbol as placeholder until we have card images
                Image(systemName: "questionmark.app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(12)
                
                Text(card.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                if isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Text(interpretation)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
        }
        .onAppear {
            // Here we'll later add the AI interpretation logic
            // For now, just show the basic meaning
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch mode {
                case .randomReading:
                    interpretation = card.meaning
                case .questionReading(let question):
                    interpretation = "Question: \(question)\n\nBased on \(card.name): \(card.meaning)"
                }
                isLoading = false
            }
        }
    }
} 