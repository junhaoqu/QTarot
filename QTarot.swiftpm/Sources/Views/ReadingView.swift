import SwiftUI

struct ReadingView: View {
    let card: TarotCard
    let mode: ReadingMode
    @Environment(\.dismiss) private var dismiss
    @State private var isRevealed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Async image loading: if your imageName is a full URL,
                // you can load from the network. Otherwise, replace with your local image logic.
                AsyncImage(url: URL(string: card.imageName)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    // Fallback (e.g., card back)
                    Image(card.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 300)
                .shadow(radius: 10)
                
                // Card details
                VStack(alignment: .leading, spacing: 12) {
                    Text(card.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Use a transition so content fades/moves in
                    if isRevealed {
                        // Core meaning (or "Attention:" for reversed)
                        if !card.meaning.isEmpty {
                            Text("Meaning:")
                                .font(.headline)
                            Text(card.meaning)
                                .font(.body)
                                .padding(.bottom, 8)
                        }
                        
                        // Daily life advice (empty for reversed cards)
                        if !card.dailyLife.isEmpty {
                            Text("Today's Fortune:")
                                .font(.headline)
                            Text(card.dailyLife)
                                .font(.body)
                                .padding(.bottom, 8)
                        }
                        
                        // Relationship advice (empty for reversed cards)
                        if !card.relationship.isEmpty {
                            Text("Relationship:")
                                .font(.headline)
                            Text(card.relationship)
                                .font(.body)
                                .padding(.bottom, 8)
                        }
                        
                        // Job/Financial/Professional advice (empty for reversed cards)
                        if !card.job.isEmpty {
                            Text("Work:")
                                .font(.headline)
                            Text(card.job)
                                .font(.body)
                                .padding(.bottom, 8)
                        }
                        
                        // If user wants the reversed meaning in full reading mode
                        if case .fullReading = mode, !card.reversedMeaning.isEmpty {
                            Text("Reversed Meaning:")
                                .font(.headline)
                            Text(card.reversedMeaning)
                                .font(.body)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
        .onAppear {
            // Delay the reveal slightly to let the transition finish
            withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
                isRevealed = true
            }
        }
    }
}
