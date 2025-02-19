import SwiftUI

struct ContentView: View {
    @State private var showingQuestionInput = false
    @State private var selectedMode: ReadingMode = .randomReading // 使用 Models 中定义的 ReadingMode
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("QTarot")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 20) {
                    NavigationLink {
                        TarotCardGridView(mode: .randomReading)
                    } label: {
                        MenuButton(title: "Start with a Card", 
                                 subtitle: "Pick a card for general guidance",
                                 systemImage: "questionmark.app.fill")
                    }
                    
                    NavigationLink {
                        QuestionInputView()
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
