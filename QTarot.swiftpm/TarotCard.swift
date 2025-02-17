import Foundation

struct TarotCard: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let meaning: String
    let reversedMeaning: String
}

@MainActor
class TarotDeck {
    static let shared = TarotDeck()
    
    let cards: [TarotCard]
    
    private init() {
        self.cards = [
            TarotCard(
                name: "The Fool",
                imageName: "fool",
                meaning: "New beginnings, spontaneity, faith in the universe. The Fool represents the start of a journey, innocence, and taking a leap of faith.",
                reversedMeaning: "Recklessness, risk-taking without thought, inconsideration of consequences"
            ),
            TarotCard(
                name: "The Magician",
                imageName: "magician",
                meaning: "Manifestation, resourcefulness, power, inspired action. The Magician represents your ability to utilize all your skills and resources to achieve your goals.",
                reversedMeaning: "Manipulation, poor planning, untapped talents, wasted potential"
            ),
            TarotCard(
                name: "The High Priestess",
                imageName: "highpriestess",
                meaning: "Intuition, sacred knowledge, divine feminine, the subconscious mind. The High Priestess represents mystery, inner knowledge, and trusting your instincts.",
                reversedMeaning: "Secrets being kept from you, disconnected from intuition, withdrawal and silence"
            ),
            TarotCard(
                name: "The Empress",
                imageName: "empress",
                meaning: "Abundance, nurturing, fertility, life in all its forms. The Empress represents creation, growth, and the nurturing of ideas or relationships.",
                reversedMeaning: "Creative block, dependence on others, emptiness, lack of growth"
            )
        ]
    }
} 