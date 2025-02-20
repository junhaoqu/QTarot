import Foundation

struct TarotCard: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let meaning: String            // Core meaning or "Attention:" for reversed
    let dailyLife: String          // Upright only; empty for reversed
    let relationship: String       // Upright only; empty for reversed
    let job: String                // Upright only; empty for reversed
    let reversedMeaning: String    // Unused here; can remain blank
}

@MainActor
class TarotDeck {
    static let shared = TarotDeck()
    
    let cards: [TarotCard]
    
    private init() {
        self.cards = [
            // MARK: Major Arcana – Upright
            TarotCard(
                name: "The Fool",
                imageName: "fool",
                meaning: "New beginnings, spontaneity, and a leap of faith.",
                dailyLife: "Embrace adventure and take fresh opportunities.",
                relationship: "Be open and spontaneous in your connections.",
                job: "Consider new ventures with cautious optimism.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Magician",
                imageName: "magician",
                meaning: "Manifestation and resourcefulness.",
                dailyLife: "Utilize your skills to create opportunities.",
                relationship: "Communicate effectively and showcase your talents.",
                job: "Channel creativity to advance your career or studies.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The High Priestess",
                imageName: "highpriestess",
                meaning: "Intuition and inner wisdom.",
                dailyLife: "Trust your instincts and seek inner guidance.",
                relationship: "Listen to your inner voice for authentic bonds.",
                job: "Let intuition guide your decisions.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Empress",
                imageName: "empress",
                meaning: "Abundance, nurturing, and creativity.",
                dailyLife: "Foster growth and practice self-care.",
                relationship: "Nurture love and supportive connections.",
                job: "Invest in creative projects and sustainable ventures.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Emperor",
                imageName: "emperor",
                meaning: "Authority, structure, and leadership.",
                dailyLife: "Establish order and take charge.",
                relationship: "Build stable and respectful bonds.",
                job: "Implement disciplined strategies in your work and finances.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hierophant",
                imageName: "hierophant",
                meaning: "Tradition and spiritual wisdom.",
                dailyLife: "Follow time-tested practices that suit you.",
                relationship: "Value loyalty and shared beliefs.",
                job: "Adhere to conventional methods in your pursuits.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Lovers",
                imageName: "lovers",
                meaning: "Union and deep connection.",
                dailyLife: "Embrace harmony and balanced choices.",
                relationship: "Foster love and mutual support.",
                job: "Collaborate and align your professional goals.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Chariot",
                imageName: "chariot",
                meaning: "Control and determination.",
                dailyLife: "Drive forward with focus.",
                relationship: "Lead with clear boundaries.",
                job: "Pursue your goals with discipline and strategic planning.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Strength",
                imageName: "strength",
                meaning: "Courage, compassion, and resilience.",
                dailyLife: "Face challenges with calm determination.",
                relationship: "Show gentle strength and care.",
                job: "Overcome obstacles with inner fortitude.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hermit",
                imageName: "hermit",
                meaning: "Introspection and inner guidance.",
                dailyLife: "Take time for solitude and reflection.",
                relationship: "Seek depth through self-understanding.",
                job: "Plan your path with careful thought.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Wheel of Fortune",
                imageName: "wheeloffortune",
                meaning: "Cycles and destiny.",
                dailyLife: "Embrace change and the natural cycles.",
                relationship: "Accept ups and downs in partnerships.",
                job: "Adapt to shifting circumstances.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Justice",
                imageName: "justice",
                meaning: "Fairness and balance.",
                dailyLife: "Strive for equilibrium and fair decisions.",
                relationship: "Maintain honesty and balance.",
                job: "Seek ethical and balanced choices.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hanged Man",
                imageName: "hangedman",
                meaning: "Surrender and new perspectives.",
                dailyLife: "Pause to gain fresh insights.",
                relationship: "Allow space for change and understanding.",
                job: "Consider alternative strategies.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Death",
                imageName: "death",
                meaning: "Transformation and renewal.",
                dailyLife: "Embrace endings as opportunities for new beginnings.",
                relationship: "Let go of what no longer serves you.",
                job: "Reinvent your approach.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Temperance",
                imageName: "temperance",
                meaning: "Balance and moderation.",
                dailyLife: "Practice equilibrium in your habits.",
                relationship: "Cultivate harmonious connections.",
                job: "Plan actions with moderation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Devil",
                imageName: "devil",
                meaning: "Temptation and materialism.",
                dailyLife: "Recognize limiting patterns and work to overcome them.",
                relationship: "Be cautious of unhealthy dependencies.",
                job: "Monitor overindulgence and impulsiveness.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Tower",
                imageName: "tower",
                meaning: "Upheaval and revelation.",
                dailyLife: "Expect sudden changes that clear outdated structures.",
                relationship: "Prepare for disruptions that lead to truth.",
                job: "Reevaluate your path after unexpected events.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Star",
                imageName: "star",
                meaning: "Hope and inspiration.",
                dailyLife: "Let optimism guide your actions.",
                relationship: "Foster healing and supportive bonds.",
                job: "Pursue opportunities with renewed creativity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Moon",
                imageName: "moon",
                meaning: "Illusion and intuition.",
                dailyLife: "Trust your inner light amid uncertainty.",
                relationship: "Seek clarity in complex connections.",
                job: "Navigate challenges with caution.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Sun",
                imageName: "sun",
                meaning: "Joy and vitality.",
                dailyLife: "Embrace positivity and celebrate achievements.",
                relationship: "Radiate warmth and encourage strong bonds.",
                job: "Pursue success with confidence.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Judgement",
                imageName: "judgement",
                meaning: "Rebirth and self-reflection.",
                dailyLife: "Review your actions and renew your spirit.",
                relationship: "Strengthen connections through honest reassessment.",
                job: "Make thoughtful decisions for renewal.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The World",
                imageName: "world",
                meaning: "Completion and fulfillment.",
                dailyLife: "Celebrate achievements and embrace wholeness.",
                relationship: "Cherish lasting bonds.",
                job: "Solidify your goals with confidence.",
                reversedMeaning: ""
            ),
            
            // MARK: Major Arcana – Reversed
            TarotCard(
                name: "The Fool (Reversed)",
                imageName: "fool_reversed",
                meaning: "Attention: Beware of recklessness and impulsive decisions.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Magician (Reversed)",
                imageName: "magician_reversed",
                meaning: "Attention: Avoid manipulation and poor planning; use your skills honestly.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The High Priestess (Reversed)",
                imageName: "highpriestess_reversed",
                meaning: "Attention: Be cautious of secrets and blocked intuition; avoid isolation.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Empress (Reversed)",
                imageName: "empress_reversed",
                meaning: "Attention: Watch for creative blocks and overdependence; be alert to stagnation.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Emperor (Reversed)",
                imageName: "emperor_reversed",
                meaning: "Attention: Avoid domination and rigidity; be mindful of over-control.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hierophant (Reversed)",
                imageName: "hierophant_reversed",
                meaning: "Attention: Question outdated norms and remain open to unconventional ideas.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Lovers (Reversed)",
                imageName: "lovers_reversed",
                meaning: "Attention: Be aware of disharmony and misaligned values; avoid forced choices.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Chariot (Reversed)",
                imageName: "chariot_reversed",
                meaning: "Attention: Avoid losing direction or aggression; keep focus and balance.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Strength (Reversed)",
                imageName: "strength_reversed",
                meaning: "Attention: Beware of self-doubt and impulsivity; work on building inner confidence.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hermit (Reversed)",
                imageName: "hermit_reversed",
                meaning: "Attention: Avoid excessive isolation; ensure you remain connected to support.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Wheel of Fortune (Reversed)",
                imageName: "wheeloffortune_reversed",
                meaning: "Attention: Be wary of resisting change; remain adaptable to life's cycles.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Justice (Reversed)",
                imageName: "justice_reversed",
                meaning: "Attention: Avoid injustice and dishonesty; address imbalances promptly.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hanged Man (Reversed)",
                imageName: "hangedman_reversed",
                meaning: "Attention: Avoid stagnation and resistance; be careful of self-sacrifice.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Death (Reversed)",
                imageName: "death_reversed",
                meaning: "Attention: Do not fear change or cling to the past; embrace transformation.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Temperance (Reversed)",
                imageName: "temperance_reversed",
                meaning: "Attention: Beware of excess and imbalance; avoid impulsive behavior.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Devil (Reversed)",
                imageName: "devil_reversed",
                meaning: "Attention: Break free from unhealthy patterns; be mindful of attachments.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Tower (Reversed)",
                imageName: "tower_reversed",
                meaning: "Attention: Do not avoid necessary change; face disruptions with resilience.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Star (Reversed)",
                imageName: "star_reversed",
                meaning: "Attention: Avoid losing hope or becoming disconnected; address discouragement.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Moon (Reversed)",
                imageName: "moon_reversed",
                meaning: "Attention: Be alert to confusion and hidden fears; guard against misinterpretations.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Sun (Reversed)",
                imageName: "sun_reversed",
                meaning: "Attention: Avoid overexposure and fleeting success; balance enthusiasm with realism.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Judgement (Reversed)",
                imageName: "judgement_reversed",
                meaning: "Attention: Avoid self-doubt and regret; focus on constructive renewal.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The World (Reversed)",
                imageName: "world_reversed",
                meaning: "Attention: Watch for delays or incompletion; resolve unresolved issues.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Wands Upright
            TarotCard(
                name: "Ace of Wands",
                imageName: "ace_wands",
                meaning: "Spark of inspiration and creative energy.",
                dailyLife: "Initiate projects with enthusiasm.",
                relationship: "Express passion and creativity.",
                job: "Take initiative with innovative ideas.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Wands",
                imageName: "two_wands",
                meaning: "Planning and foresight.",
                dailyLife: "Plan your day with a clear vision.",
                relationship: "Collaborate and set mutual goals.",
                job: "Strategize career moves and finances.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Wands",
                imageName: "three_wands",
                meaning: "Expansion and growth.",
                dailyLife: "Look ahead and embrace new opportunities.",
                relationship: "Encourage collaborative growth.",
                job: "Pursue opportunities for advancement.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Wands",
                imageName: "four_wands",
                meaning: "Celebration and stability.",
                dailyLife: "Enjoy moments of harmony and success.",
                relationship: "Strengthen bonds through shared joy.",
                job: "Build a secure foundation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Wands",
                imageName: "five_wands",
                meaning: "Challenge and competition.",
                dailyLife: "Face minor conflicts with resilience.",
                relationship: "Navigate competitive dynamics fairly.",
                job: "Turn challenges into growth opportunities.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Wands",
                imageName: "six_wands",
                meaning: "Victory and recognition.",
                dailyLife: "Celebrate your successes confidently.",
                relationship: "Share your achievements to inspire.",
                job: "Leverage professional wins for further growth.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Wands",
                imageName: "seven_wands",
                meaning: "Perseverance and defense.",
                dailyLife: "Stand your ground with determination.",
                relationship: "Assert your boundaries respectfully.",
                job: "Defend your ideas with confidence.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Wands",
                imageName: "eight_wands",
                meaning: "Swift action and movement.",
                dailyLife: "Act quickly to seize opportunities.",
                relationship: "Communicate with speed and clarity.",
                job: "Pursue career moves with rapid progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Wands",
                imageName: "nine_wands",
                meaning: "Resilience and persistence.",
                dailyLife: "Maintain strength in adversity.",
                relationship: "Protect your boundaries.",
                job: "Push through professional challenges.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Wands",
                imageName: "ten_wands",
                meaning: "Burden and responsibility.",
                dailyLife: "Recognize when you're overburdened.",
                relationship: "Communicate your limits clearly.",
                job: "Delegate tasks and streamline workload.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Wands",
                imageName: "page_wands",
                meaning: "Curiosity and exploration.",
                dailyLife: "Embrace learning and new experiences.",
                relationship: "Express enthusiasm in your interactions.",
                job: "Explore creative approaches in your work.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Wands",
                imageName: "knight_wands",
                meaning: "Adventure and dynamic action.",
                dailyLife: "Pursue your goals with passion.",
                relationship: "Bring energy and excitement.",
                job: "Take bold steps in your professional life.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Wands",
                imageName: "queen_wands",
                meaning: "Passion and warmth.",
                dailyLife: "Radiate confidence and creativity.",
                relationship: "Nurture bonds with heartfelt care.",
                job: "Lead with innovative ideas.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Wands",
                imageName: "king_wands",
                meaning: "Leadership and vision.",
                dailyLife: "Direct your energy towards clear goals.",
                relationship: "Inspire and guide with integrity.",
                job: "Steer your professional life with bold strategy.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Wands Reversed
            TarotCard(
                name: "Ace of Wands (Reversed)",
                imageName: "ace_wands_reversed",
                meaning: "Attention: Avoid delays and missed opportunities; be wary of stagnation in creativity.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Wands (Reversed)",
                imageName: "two_wands_reversed",
                meaning: "Attention: Be cautious of indecision and fear of change; avoid paralysis by overthinking.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Wands (Reversed)",
                imageName: "three_wands_reversed",
                meaning: "Attention: Watch for obstacles and delays; remain flexible and adaptable.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Wands (Reversed)",
                imageName: "four_wands_reversed",
                meaning: "Attention: Be aware of instability and disrupted celebrations; address underlying issues.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Wands (Reversed)",
                imageName: "five_wands_reversed",
                meaning: "Attention: Avoid unresolved conflict and tension; strive for constructive resolution.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Wands (Reversed)",
                imageName: "six_wands_reversed",
                meaning: "Attention: Be cautious of an excessive need for validation; avoid feelings of defeat.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Wands (Reversed)",
                imageName: "seven_wands_reversed",
                meaning: "Attention: Avoid feeling overwhelmed or overly defensive; reassess your strategies calmly.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Wands (Reversed)",
                imageName: "eight_wands_reversed",
                meaning: "Attention: Beware of scattered energy and delays; ensure focus in your actions.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Wands (Reversed)",
                imageName: "nine_wands_reversed",
                meaning: "Attention: Avoid burnout and defensiveness; manage your energy wisely.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Wands (Reversed)",
                imageName: "ten_wands_reversed",
                meaning: "Attention: Be alert to overwhelm and exhaustion; consider releasing unnecessary burdens.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Wands (Reversed)",
                imageName: "page_wands_reversed",
                meaning: "Attention: Avoid impulsiveness and lack of direction; focus your energy constructively.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Wands (Reversed)",
                imageName: "knight_wands_reversed",
                meaning: "Attention: Beware of impulsivity and scattered focus; plan your actions carefully.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Wands (Reversed)",
                imageName: "queen_wands_reversed",
                meaning: "Attention: Be cautious of jealousy and insecurity; work on building self-confidence.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Wands (Reversed)",
                imageName: "king_wands_reversed",
                meaning: "Attention: Avoid domineering behavior and impulsiveness; maintain balanced leadership.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Cups Upright
            TarotCard(
                name: "Ace of Cups",
                imageName: "ace_cups",
                meaning: "New love and emotional fulfillment.",
                dailyLife: "Open your heart to new beginnings.",
                relationship: "Express genuine affection and empathy.",
                job: "Use emotional insight to guide decisions.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Cups",
                imageName: "two_cups",
                meaning: "Partnership and harmony.",
                dailyLife: "Foster balanced interactions.",
                relationship: "Cultivate mutual respect and deep connection.",
                job: "Collaborate effectively in your endeavors.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Cups",
                imageName: "three_cups",
                meaning: "Celebration and friendship.",
                dailyLife: "Enjoy social moments and joyful gatherings.",
                relationship: "Strengthen bonds through shared celebrations.",
                job: "Utilize teamwork for success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Cups",
                imageName: "four_cups",
                meaning: "Contemplation and reevaluation.",
                dailyLife: "Reflect on your routine and seek fresh motivation.",
                relationship: "Reassess your connections with gratitude.",
                job: "Consider new opportunities in your path.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Cups",
                imageName: "five_cups",
                meaning: "Loss and reflection.",
                dailyLife: "Acknowledge your emotions and learn from setbacks.",
                relationship: "Address grief and work toward healing.",
                job: "Reevaluate your strategies for recovery.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Cups",
                imageName: "six_cups",
                meaning: "Nostalgia and joyful memories.",
                dailyLife: "Cherish positive moments from the past.",
                relationship: "Reconnect with loved ones.",
                job: "Let past successes inspire future endeavors.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Cups",
                imageName: "seven_cups",
                meaning: "Choices and dreams.",
                dailyLife: "Evaluate your options and follow your intuition.",
                relationship: "Communicate clearly to align expectations.",
                job: "Set realistic goals for progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Cups",
                imageName: "eight_cups",
                meaning: "Seeking deeper meaning.",
                dailyLife: "Leave behind what no longer serves you.",
                relationship: "Reassess your emotional investments.",
                job: "Pursue work that resonates with your values.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Cups",
                imageName: "nine_cups",
                meaning: "Contentment and satisfaction.",
                dailyLife: "Appreciate daily joys and small victories.",
                relationship: "Celebrate harmonious bonds.",
                job: "Enjoy the fruits of your labor.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Cups",
                imageName: "ten_cups",
                meaning: "Family and lasting happiness.",
                dailyLife: "Embrace the warmth of home and community.",
                relationship: "Foster loving and supportive connections.",
                job: "Build a secure foundation for your future.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Cups",
                imageName: "page_cups",
                meaning: "Creative expression and sensitivity.",
                dailyLife: "Explore new creative pursuits.",
                relationship: "Show genuine care and openness.",
                job: "Infuse creativity into your work or studies.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Cups",
                imageName: "knight_cups",
                meaning: "Romance and idealism.",
                dailyLife: "Pursue your dreams with a loving heart.",
                relationship: "Engage in heartfelt and sincere connections.",
                job: "Let passion guide your professional choices.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Cups",
                imageName: "queen_cups",
                meaning: "Emotional balance and empathy.",
                dailyLife: "Prioritize self-care and maintain inner calm.",
                relationship: "Offer support and understanding.",
                job: "Use your insight to navigate challenges.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Cups",
                imageName: "king_cups",
                meaning: "Emotional wisdom and diplomacy.",
                dailyLife: "Keep a balanced emotional outlook.",
                relationship: "Lead with compassion and understanding.",
                job: "Make thoughtful decisions in your pursuits.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Cups Reversed
            TarotCard(
                name: "Ace of Cups (Reversed)",
                imageName: "ace_cups_reversed",
                meaning: "Attention: Beware of emotional blockage and emptiness; be mindful of over-sensitivity.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Cups (Reversed)",
                imageName: "two_cups_reversed",
                meaning: "Attention: Watch for imbalance and misaligned values; address disconnects in partnerships.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Cups (Reversed)",
                imageName: "three_cups_reversed",
                meaning: "Attention: Avoid overindulgence and gossip; maintain clarity and sincerity in social interactions.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Cups (Reversed)",
                imageName: "four_cups_reversed",
                meaning: "Attention: Be aware of apathy and missed opportunities; actively seek new motivation.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Cups (Reversed)",
                imageName: "five_cups_reversed",
                meaning: "Attention: Avoid dwelling on past regrets; focus on recovery and moving forward.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Cups (Reversed)",
                imageName: "six_cups_reversed",
                meaning: "Attention: Avoid getting stuck in the past; focus on present opportunities and growth.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Cups (Reversed)",
                imageName: "seven_cups_reversed",
                meaning: "Attention: Beware of confusion and unrealistic dreams; narrow your focus and clarify priorities.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Cups (Reversed)",
                imageName: "eight_cups_reversed",
                meaning: "Attention: Avoid fear of change and stagnation; be open to new paths and opportunities.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Cups (Reversed)",
                imageName: "nine_cups_reversed",
                meaning: "Attention: Avoid overindulgence and superficial satisfaction; seek deeper fulfillment.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Cups (Reversed)",
                imageName: "ten_cups_reversed",
                meaning: "Attention: Be mindful of broken promises and unmet expectations; work on healing relational gaps.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Cups (Reversed)",
                imageName: "page_cups_reversed",
                meaning: "Attention: Avoid emotional immaturity and insecurity; nurture self-confidence and clarity.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Cups (Reversed)",
                imageName: "knight_cups_reversed",
                meaning: "Attention: Beware of unrealistic expectations and moodiness; maintain balance and practicality.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Cups (Reversed)",
                imageName: "queen_cups_reversed",
                meaning: "Attention: Avoid emotional instability and dependency; cultivate inner strength and balance.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Cups (Reversed)",
                imageName: "king_cups_reversed",
                meaning: "Attention: Be cautious of moodiness and manipulation; strive for clarity and emotional balance.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Swords Upright
            TarotCard(
                name: "Ace of Swords",
                imageName: "ace_swords",
                meaning: "Clarity and breakthrough.",
                dailyLife: "Embrace clear thinking and decisive action.",
                relationship: "Communicate your truth effectively.",
                job: "Innovate with sharp ideas.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Swords",
                imageName: "two_swords",
                meaning: "Decision and balance.",
                dailyLife: "Make balanced choices in your routine.",
                relationship: "Engage in fair dialogue.",
                job: "Assess your options carefully.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Swords",
                imageName: "three_swords",
                meaning: "Heartbreak and healing.",
                dailyLife: "Process emotional pain and learn from setbacks.",
                relationship: "Address hurt feelings openly.",
                job: "Improve future decisions from past lessons.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Swords",
                imageName: "four_swords",
                meaning: "Rest and recovery.",
                dailyLife: "Take time for self-care and rejuvenation.",
                relationship: "Give space for healing.",
                job: "Reassess your goals with a fresh perspective.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Swords",
                imageName: "five_swords",
                meaning: "Conflict and resolution.",
                dailyLife: "Address conflicts with calm.",
                relationship: "Strive for peaceful communication.",
                job: "Resolve disputes with clarity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Swords",
                imageName: "six_swords",
                meaning: "Transition and moving on.",
                dailyLife: "Embrace change and leave behind what no longer serves you.",
                relationship: "Communicate needed changes.",
                job: "Seek new opportunities to advance.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Swords",
                imageName: "seven_swords",
                meaning: "Strategy and subtlety.",
                dailyLife: "Plan your actions with care.",
                relationship: "Be honest and direct.",
                job: "Utilize strategic thinking in your pursuits.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Swords",
                imageName: "eight_swords",
                meaning: "Restriction and challenge.",
                dailyLife: "Identify self-imposed limits and work to overcome them.",
                relationship: "Communicate boundaries clearly.",
                job: "Seek solutions to obstacles.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Swords",
                imageName: "nine_swords",
                meaning: "Anxiety and worry.",
                dailyLife: "Acknowledge your fears and seek calm.",
                relationship: "Share concerns with trusted ones.",
                job: "Address stressors affecting your work.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Swords",
                imageName: "ten_swords",
                meaning: "Endings and release.",
                dailyLife: "Accept the end of a cycle and move on.",
                relationship: "Heal from past hurts.",
                job: "Rebuild with new strategies.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Swords",
                imageName: "page_swords",
                meaning: "Curiosity and vigilance.",
                dailyLife: "Stay alert and open to new ideas.",
                relationship: "Communicate clearly and listen actively.",
                job: "Apply innovative ideas in your environment.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Swords",
                imageName: "knight_swords",
                meaning: "Action and assertiveness.",
                dailyLife: "Take decisive steps and be bold.",
                relationship: "Express your views honestly.",
                job: "Drive forward with confidence.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Swords",
                imageName: "queen_swords",
                meaning: "Clarity and independence.",
                dailyLife: "Maintain clear thoughts and articulate ideas.",
                relationship: "Value honesty and direct communication.",
                job: "Strategize with intellect.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Swords",
                imageName: "king_swords",
                meaning: "Authority and insight.",
                dailyLife: "Use analytical thinking to guide your day.",
                relationship: "Lead with fairness and truth.",
                job: "Make strategic decisions.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Swords Reversed
            TarotCard(
                name: "Ace of Swords (Reversed)",
                imageName: "ace_swords_reversed",
                meaning: "Attention: Avoid confusion and unclear intentions; work to gain mental clarity.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Swords (Reversed)",
                imageName: "two_swords_reversed",
                meaning: "Attention: Be aware of indecision and avoidance; address uncertainties directly.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Swords (Reversed)",
                imageName: "three_swords_reversed",
                meaning: "Attention: Beware of lingering sorrow and unhealed wounds; work on forgiveness.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Swords (Reversed)",
                imageName: "four_swords_reversed",
                meaning: "Attention: Avoid burnout and constant stress; balance work with sufficient rest.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Swords (Reversed)",
                imageName: "five_swords_reversed",
                meaning: "Attention: Beware of unresolved tension and regret; aim for compromise and resolution.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Swords (Reversed)",
                imageName: "six_swords_reversed",
                meaning: "Attention: Avoid resistance to change and lingering attachments; remain open to new paths.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Swords (Reversed)",
                imageName: "seven_swords_reversed",
                meaning: "Attention: Beware of dishonesty and underhanded tactics; maintain integrity in all dealings.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Swords (Reversed)",
                imageName: "eight_swords_reversed",
                meaning: "Attention: Avoid feeling trapped and helpless; explore opportunities for freedom and clarity.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Swords (Reversed)",
                imageName: "nine_swords_reversed",
                meaning: "Attention: Beware of excessive worry and mental distress; practice mindfulness and seek balance.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Swords (Reversed)",
                imageName: "ten_swords_reversed",
                meaning: "Attention: Avoid lingering pain and inability to move forward; seek renewal and healing.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Swords (Reversed)",
                imageName: "page_swords_reversed",
                meaning: "Attention: Beware of gossip and impulsiveness; focus on clear and honest communication.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Swords (Reversed)",
                imageName: "knight_swords_reversed",
                meaning: "Attention: Avoid rash decisions and aggressive behavior; think before acting and maintain balance.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Swords (Reversed)",
                imageName: "queen_swords_reversed",
                meaning: "Attention: Beware of coldness and bitterness; balance logic with empathy and warmth.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Swords (Reversed)",
                imageName: "king_swords_reversed",
                meaning: "Attention: Avoid tyrannical or manipulative tendencies; strive for balanced judgment and fairness.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Pentacles Upright
            TarotCard(
                name: "Ace of Pentacles",
                imageName: "ace_pentacles",
                meaning: "New opportunities and prosperity.",
                dailyLife: "Seize growth opportunities.",
                relationship: "Cultivate secure, nurturing bonds.",
                job: "Embrace fresh ventures with practical steps.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Pentacles",
                imageName: "two_pentacles",
                meaning: "Balance and adaptability.",
                dailyLife: "Manage your day with flexibility.",
                relationship: "Maintain harmonious interactions.",
                job: "Juggle responsibilities with agility.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Pentacles",
                imageName: "three_pentacles",
                meaning: "Collaboration and skill.",
                dailyLife: "Work well with others and build on your strengths.",
                relationship: "Foster teamwork.",
                job: "Excel through cooperation and craftsmanship.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Pentacles",
                imageName: "four_pentacles",
                meaning: "Stability and security.",
                dailyLife: "Build a solid foundation.",
                relationship: "Establish clear boundaries.",
                job: "Manage finances with care and consistency.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Pentacles",
                imageName: "five_pentacles",
                meaning: "Hardship and challenge.",
                dailyLife: "Acknowledge struggles and seek support.",
                relationship: "Reach out during tough times.",
                job: "Reevaluate challenges for improvement.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Pentacles",
                imageName: "six_pentacles",
                meaning: "Generosity and balance.",
                dailyLife: "Share your abundance and appreciate help.",
                relationship: "Engage in fair exchanges.",
                job: "Aim for balanced professional dealings.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Pentacles",
                imageName: "seven_pentacles",
                meaning: "Patience and long-term growth.",
                dailyLife: "Invest time in nurturing your pursuits.",
                relationship: "Cultivate steady connections.",
                job: "Focus on long-term progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Pentacles",
                imageName: "eight_pentacles",
                meaning: "Diligence and mastery.",
                dailyLife: "Focus on honing your skills.",
                relationship: "Invest time in nurturing bonds.",
                job: "Improve professionally through dedicated practice.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Pentacles",
                imageName: "nine_pentacles",
                meaning: "Independence and luxury.",
                dailyLife: "Enjoy personal comfort and success.",
                relationship: "Cultivate self-sufficient bonds.",
                job: "Secure financial success with prudence.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Pentacles",
                imageName: "ten_pentacles",
                meaning: "Wealth and legacy.",
                dailyLife: "Embrace stability and long-term achievements.",
                relationship: "Build lasting bonds with family.",
                job: "Plan for sustained security.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Pentacles",
                imageName: "page_pentacles",
                meaning: "Curiosity and ambition.",
                dailyLife: "Pursue learning with enthusiasm and practicality.",
                relationship: "Engage in sincere, supportive connections.",
                job: "Explore new opportunities with focus.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Pentacles",
                imageName: "knight_pentacles",
                meaning: "Responsibility and perseverance.",
                dailyLife: "Work steadily with dedication.",
                relationship: "Value reliability and practical support.",
                job: "Advance with consistent effort.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Pentacles",
                imageName: "queen_pentacles",
                meaning: "Nurturing and practicality.",
                dailyLife: "Cultivate a balanced, secure routine.",
                relationship: "Offer care and stability.",
                job: "Manage career and finances with a practical approach.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Pentacles",
                imageName: "king_pentacles",
                meaning: "Security and success.",
                dailyLife: "Build a solid, structured environment.",
                relationship: "Lead with stability and care.",
                job: "Strive for financial and career achievements with balance.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Pentacles Reversed
            TarotCard(
                name: "Ace of Pentacles (Reversed)",
                imageName: "ace_pentacles_reversed",
                meaning: "Attention: Watch for missed opportunities and financial setbacks; stay grounded and practical.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Pentacles (Reversed)",
                imageName: "two_pentacles_reversed",
                meaning: "Attention: Avoid overwhelm and disorganization; re-prioritize and manage tasks effectively.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Pentacles (Reversed)",
                imageName: "three_pentacles_reversed",
                meaning: "Attention: Be mindful of poor planning and lack of teamwork; refine your approach and collaborate better.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Pentacles (Reversed)",
                imageName: "four_pentacles_reversed",
                meaning: "Attention: Avoid greed and rigidity; be open to change and sharing resources.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Pentacles (Reversed)",
                imageName: "five_pentacles_reversed",
                meaning: "Attention: Watch for signs of isolation and financial hardship; seek support and recovery.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Pentacles (Reversed)",
                imageName: "six_pentacles_reversed",
                meaning: "Attention: Avoid inequality and dependency; strive for fair, balanced exchanges.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Pentacles (Reversed)",
                imageName: "seven_pentacles_reversed",
                meaning: "Attention: Beware of impatience and poor investment; assess your progress realistically.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Pentacles (Reversed)",
                imageName: "eight_pentacles_reversed",
                meaning: "Attention: Avoid lack of focus and incomplete projects; strive for consistency and mastery.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Pentacles (Reversed)",
                imageName: "nine_pentacles_reversed",
                meaning: "Attention: Beware of isolation and overindulgence; maintain a balanced and connected approach.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Pentacles (Reversed)",
                imageName: "ten_pentacles_reversed",
                meaning: "Attention: Watch out for instability and discord in legacy; reassess your long-term plans.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Pentacles (Reversed)",
                imageName: "page_pentacles_reversed",
                meaning: "Attention: Avoid lack of ambition and procrastination; set clear, achievable goals.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Pentacles (Reversed)",
                imageName: "knight_pentacles_reversed",
                meaning: "Attention: Beware of stagnation and stubborn routines; re-evaluate your methods for growth.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Pentacles (Reversed)",
                imageName: "queen_pentacles_reversed",
                meaning: "Attention: Avoid overprotectiveness and materialism; remain open to new opportunities and growth.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Pentacles (Reversed)",
                imageName: "king_pentacles_reversed",
                meaning: "Attention: Watch for stubbornness and greed; ensure fair and flexible leadership in your endeavors.",
                dailyLife: "",
                relationship: "",
                job: "",
                reversedMeaning: ""
            )
        ]
    }
}
