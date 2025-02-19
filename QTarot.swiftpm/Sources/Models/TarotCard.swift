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
            ),
            TarotCard(
                name: "The Emperor",
                imageName: "emperor",
                meaning: "Authority, structure, control, fatherhood. The Emperor represents leadership, stability, and the establishment of secure foundations.",
                reversedMeaning: "Domination, excessive control, lack of discipline, inflexibility"
            ),
            TarotCard(
                name: "The Hierophant",
                imageName: "hierophant",
                meaning: "Tradition, conformity, morality, ethics. The Hierophant represents spiritual wisdom, religious beliefs, and conforming to the rules.",
                reversedMeaning: "Rebellion, subversiveness, new approaches, unconventional methods"
            ),
            TarotCard(
                name: "The Lovers",
                imageName: "lovers",
                meaning: "Love, harmony, relationships, values alignment. The Lovers represents perfect union, choices, and alignment of values.",
                reversedMeaning: "Disharmony, imbalance, misalignment of values, separation"
            ),
            TarotCard(
                name: "The Chariot",
                imageName: "chariot",
                meaning: "Control, willpower, success, determination. The Chariot represents overcoming obstacles, moving forward, and achieving goals.",
                reversedMeaning: "Lack of direction, aggression, defeat, lack of control"
            ),
            TarotCard(
                name: "Strength",
                imageName: "strength",
                meaning: "Strength, courage, patience, compassion. Strength represents inner strength, fortitude, and gentle control.",
                reversedMeaning: "Self-doubt, weakness, lack of self-discipline, raw emotion"
            ),
            TarotCard(
                name: "The Hermit",
                imageName: "hermit",
                meaning: "Soul-searching, introspection, inner guidance. The Hermit represents looking inward for answers and spiritual enlightenment.",
                reversedMeaning: "Isolation, loneliness, withdrawal, rejection of others"
            )
        ]
    }
} 