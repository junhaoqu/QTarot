import SwiftUI

struct DictView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCard: TarotCard?
    @State private var showingCardDetail = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 6)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(TarotDeck.shared.cards) { card in
                    CardThumbnail(card: card, onTap: {
                        selectedCard = card
                        showingCardDetail = true
                    })
                }
            }
            .padding()
        }
        .navigationTitle("Tarot Dictionary")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Tarot Dictionary")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $showingCardDetail) {
            if let card = selectedCard {
                CardDetailView(card: card)
            }
        }
        .background(
            Image("card_back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.6))
        )
    }
}

struct CardThumbnail: View {
    let card: TarotCard
    let onTap: () -> Void
    
    var body: some View {
        Image(card.imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 180)
            .shadow(radius: 5)
            .onTapGesture(perform: onTap)
    }
}

struct CardDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let card: TarotCard
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .shadow(radius: 10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(card.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if !card.meaning.isEmpty {
                            Text("Meaning:")
                                .font(.headline)
                            Text(card.meaning)
                        }
                        
                        if !card.dailyLife.isEmpty {
                            Text("Today's Fortune:")
                                .font(.headline)
                            Text(card.dailyLife)
                        }
                        
                        if !card.relationship.isEmpty {
                            Text("Relationship:")
                                .font(.headline)
                            Text(card.relationship)
                        }
                        
                        if !card.job.isEmpty {
                            Text("Work:")
                                .font(.headline)
                            Text(card.job)
                        }
                        
                        if !card.reversedMeaning.isEmpty {
                            Text("Reversed Meaning:")
                                .font(.headline)
                            Text(card.reversedMeaning)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CardMeaningView: View {
    let card: TarotCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(card.name)
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Meaning:")
                    .font(.headline)
                Text(card.meaning)
                

            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DictView()
} 