import SwiftUI

struct TarotCardGridView: View {
    let mode: ReadingMode
    @State private var selectedCard: TarotCard?
    @State private var showingReading = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(TarotDeck.shared.cards) { card in
                    TarotCardView(card: card)
                        .onTapGesture {
                            selectedCard = card
                            showingReading = true
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Select a Card")
        .sheet(isPresented: $showingReading, content: {
            if let card = selectedCard {
                NavigationView {
                    ReadingView(card: card, mode: mode)
                        .navigationBarItems(trailing: Button("Close") {
                            showingReading = false
                        })
                }
            }
        })
    }
}

struct TarotCardView: View {
    let card: TarotCard
    
    var body: some View {
        VStack {
            // Using SF Symbols as temporary placeholders
            Image(systemName: "questionmark.app.fill")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(height: 120)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(8)
                .shadow(radius: 4)
            
            Text(card.name)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationView {
        TarotCardGridView(mode: .randomReading)
    }
} 