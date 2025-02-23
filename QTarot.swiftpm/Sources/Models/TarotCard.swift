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
                meaning: "New beginnings, spontaneity, and a leap of faith. Embrace the unknown with an open heart and curiosity.",
                dailyLife: "Stay open-minded, try new things without fear, and trust that each step leads to growth.",
                relationship: "Approach love with sincerity and optimism; be willing to take emotional risks for deeper connections.",
                job: "Consider fresh starts or novel projects. Use this energy to break from routine and spark innovation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Magician",
                imageName: "magician",
                meaning: "Manifestation and resourcefulness. You have the tools to shape your reality through focus and action.",
                dailyLife: "Apply your unique talents daily; be mindful that your thoughts and words shape outcomes.",
                relationship: "Communicate clearly; express your genuine self to foster trust and mutual growth.",
                job: "Use creativity to advance your career. Confidence and skillful execution bring tangible results.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The High Priestess",
                imageName: "highpriestess",
                meaning: "Intuition and inner wisdom. Trust your inner voice to guide you toward deeper truths.",
                dailyLife: "Carve out quiet time for reflection; honor your instincts in daily decision-making.",
                relationship: "Listen empathetically and respect emotional nuances to foster genuine bonds.",
                job: "Use intuition to navigate workplace politics; rely on subtle cues and deeper insight.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Empress",
                imageName: "empress",
                meaning: "Abundance, nurturing, and creativity. Cultivate an environment of growth and warmth.",
                dailyLife: "Practice self-care and support others’ well-being; let creativity flourish in routine tasks.",
                relationship: "Offer emotional security, compassion, and kindness; build a harmonious partnership.",
                job: "Nurture new ideas or projects; invest resources wisely for steady, sustainable success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Emperor",
                imageName: "emperor",
                meaning: "Authority, structure, and leadership. Bring order and discipline to achieve long-term goals.",
                dailyLife: "Set clear boundaries and routines; be consistent in your personal commitments.",
                relationship: "Foster respect and stability; lead with integrity but remain open to compromise.",
                job: "Implement organized strategies; focus on leadership, efficiency, and practical solutions.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hierophant",
                imageName: "hierophant",
                meaning: "Tradition and spiritual wisdom. Seek guidance in established systems or beliefs.",
                dailyLife: "Honor routines or rituals that ground you; respect cultural or family traditions.",
                relationship: "Value loyalty and shared values; strengthen bonds through mutual understanding.",
                job: "Adhere to conventional methods when needed; learn from mentors or proven practices.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Lovers",
                imageName: "lovers",
                meaning: "Union and deep connection. Reflect on choices that align with your core values.",
                dailyLife: "Seek harmony in daily decisions; aim for balance between personal needs and communal good.",
                relationship: "Foster love, trust, and mutual support; unify through open-hearted communication.",
                job: "Collaborate effectively; ensure your professional path aligns with your authentic self.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Chariot",
                imageName: "chariot",
                meaning: "Control and determination. Harness willpower to overcome obstacles.",
                dailyLife: "Set clear goals and maintain focus; manage emotions to stay on track.",
                relationship: "Establish boundaries and clarify mutual goals; lead with respect, not force.",
                job: "Pursue ambitions with discipline; strategic planning ensures victorious outcomes.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Strength",
                imageName: "strength",
                meaning: "Courage, compassion, and resilience. Inner fortitude prevails over brute force.",
                dailyLife: "Face challenges calmly; respond with patience and kindness rather than aggression.",
                relationship: "Show gentle strength; nurture empathy and support for loved ones’ vulnerabilities.",
                job: "Overcome work obstacles with perseverance; remain composed under pressure.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hermit",
                imageName: "hermit",
                meaning: "Introspection and inner guidance. Seek solitude for clarity and personal wisdom.",
                dailyLife: "Regularly unplug to reflect on personal goals; embrace quiet moments for self-growth.",
                relationship: "Deepen emotional bonds by understanding your own needs before sharing with others.",
                job: "Plan carefully and trust your inner counsel; thorough research yields enlightened solutions.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Wheel of Fortune",
                imageName: "wheeloffortune",
                meaning: "Cycles and destiny. Embrace life's changes as part of natural evolution.",
                dailyLife: "Adapt to ups and downs with grace; remain optimistic during transitions.",
                relationship: "Accept that relationships evolve; handle shifts with understanding and patience.",
                job: "Stay flexible; seizing timely opportunities can pivot your career path favorably.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Justice",
                imageName: "justice",
                meaning: "Fairness and balance. Seek truth and uphold ethical standards.",
                dailyLife: "Make impartial decisions; weigh pros and cons to maintain equilibrium.",
                relationship: "Communicate openly and resolve conflicts fairly; honesty fosters mutual respect.",
                job: "Align professional actions with moral integrity; handle disputes diplomatically.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hanged Man",
                imageName: "hangedman",
                meaning: "Surrender and new perspectives. Release old habits to see fresh insights.",
                dailyLife: "Pause and reflect; letting go of control can open unexpected possibilities.",
                relationship: "Allow space for change; empathy and patience lead to deeper understanding.",
                job: "Consider alternative strategies; reevaluating goals may yield breakthroughs.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Death",
                imageName: "death",
                meaning: "Transformation and renewal. Embrace endings to welcome new beginnings.",
                dailyLife: "Purge outdated habits or possessions; see change as a catalyst for growth.",
                relationship: "Let go of stale dynamics; a willingness to adapt can revive or redefine bonds.",
                job: "Shift career strategies or roles if they no longer serve; rebirth fosters opportunity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Temperance",
                imageName: "temperance",
                meaning: "Balance and moderation. Combine patience and adaptability for harmony.",
                dailyLife: "Cultivate healthy habits; avoid extremes in daily routines or consumption.",
                relationship: "Foster cooperative understanding; meet partners halfway for lasting unity.",
                job: "Plan methodically; blend resources and ideas to achieve steady progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Devil",
                imageName: "devil",
                meaning: "Temptation and materialism. Recognize unhealthy attachments or dependencies.",
                dailyLife: "Identify limiting beliefs or habits; strive to break free from negative cycles.",
                relationship: "Be mindful of codependent dynamics; cultivate honest, respectful interactions.",
                job: "Avoid unethical shortcuts; remain vigilant against manipulation or greed.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Tower",
                imageName: "tower",
                meaning: "Upheaval and revelation. Sudden change clears away illusions.",
                dailyLife: "Expect disruptions; adapt quickly to rebuild stronger foundations.",
                relationship: "Truth surfaces under stress; honest communication helps salvage or transform bonds.",
                job: "Reevaluate career paths after unexpected events; resilience leads to renewed clarity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Star",
                imageName: "star",
                meaning: "Hope and inspiration. Keep faith in your aspirations despite challenges.",
                dailyLife: "Foster optimism and creativity; small positive steps renew motivation.",
                relationship: "Encourage healing and openness; believe in the potential for deepened love.",
                job: "Pursue visionary goals; let hope guide innovative solutions and collaborations.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Moon",
                imageName: "moon",
                meaning: "Illusion and intuition. Trust your inner light amid uncertainty or confusion.",
                dailyLife: "Listen to your subconscious signals; reflect on hidden emotions or dreams.",
                relationship: "Seek clarity in complex situations; honesty dispels misunderstandings.",
                job: "Navigate workplace politics carefully; rely on intuition to detect unspoken undercurrents.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Sun",
                imageName: "sun",
                meaning: "Joy and vitality. Celebrate personal achievements and share positivity.",
                dailyLife: "Embrace confidence and self-expression; let your happiness uplift others.",
                relationship: "Radiate warmth; create a nurturing environment for healthy emotional growth.",
                job: "Move forward with assurance; success is likely when you maintain an upbeat mindset.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Judgement",
                imageName: "judgement",
                meaning: "Rebirth and self-reflection. Assess past actions to create a better future.",
                dailyLife: "Evaluate your progress; realign habits with personal values and goals.",
                relationship: "Foster forgiveness and renewed commitment; honest introspection brings clarity.",
                job: "Make thoughtful career choices; refine strategies based on lessons learned.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The World",
                imageName: "world",
                meaning: "Completion and fulfillment. Celebrate wholeness and the successful end of a cycle.",
                dailyLife: "Honor your achievements; maintain gratitude as you prepare for new chapters.",
                relationship: "Savor stable, mature bonds; appreciate the sense of unity and completion.",
                job: "Conclude projects with confidence; your efforts culminate in lasting success.",
                reversedMeaning: ""
            ),
            
            // MARK: Major Arcana – Reversed
            TarotCard(
                name: "The Fool (Reversed)",
                imageName: "fool_reversed",
                meaning: "ATTENTION: Carelessness or impulsive decisions. Reckless behavior may lead to missed opportunities or setbacks.",
                dailyLife: "Avoid rushing headlong into new experiences without considering real risks or responsibilities.",
                relationship: "Guard against naive expectations; impulsive moves can strain or jeopardize bonds.",
                job: "Refrain from ill-considered career shifts; ensure you have a plan before leaping.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Magician (Reversed)",
                imageName: "magician_reversed",
                meaning: "ATTENTION: Manipulation or unfocused planning. Skills may be misused or scattered.",
                dailyLife: "Stay genuine and purposeful; don't let ego or shortcuts undermine your goals.",
                relationship: "Avoid hidden agendas or deceit; honest communication is crucial for trust.",
                job: "Beware of disorganized efforts; refine your plan to harness talents productively.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The High Priestess (Reversed)",
                imageName: "highpriestess_reversed",
                meaning: "ATTENTION: Secrets, blocked intuition, or isolation. Lack of openness can create confusion.",
                dailyLife: "Avoid shutting out inner guidance; excessive secrecy may lead to poor decisions.",
                relationship: "Share feelings instead of retreating; closed-off behavior can erode intimacy.",
                job: "Be cautious of hidden workplace tensions; ignoring instincts might cause missteps.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Empress (Reversed)",
                imageName: "empress_reversed",
                meaning: "ATTENTION: Creative block, overdependence, or stagnation. Neglecting self-care fosters burnout.",
                dailyLife: "Reassess routines that stifle growth; reclaim personal nurturing and boundaries.",
                relationship: "Avoid clinging or smothering; allow mutual space to keep love flourishing.",
                job: "Address creative obstacles or complacency; refresh your approach to spark new ideas.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Emperor (Reversed)",
                imageName: "emperor_reversed",
                meaning: "ATTENTION: Over-control or rigidity. Dominating behavior hinders progress.",
                dailyLife: "Check for inflexibility in daily habits; allow room for spontaneity and balance.",
                relationship: "Avoid power struggles; mutual respect trumps dictatorial attitudes.",
                job: "Reevaluate authoritarian tactics; collaboration may yield better long-term results.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hierophant (Reversed)",
                imageName: "hierophant_reversed",
                meaning: "ATTENTION: Outdated norms or closed-mindedness. Question rigid beliefs that limit growth.",
                dailyLife: "Stay open to alternative viewpoints; challenge traditions that no longer serve you.",
                relationship: "Resist dogmatic or judgmental attitudes; nurture freedom and acceptance.",
                job: "Explore innovative methods; stepping outside comfort zones can spark advancement.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Lovers (Reversed)",
                imageName: "lovers_reversed",
                meaning: "ATTENTION: Disharmony, misaligned values, or forced choices. Lack of clarity may breed conflict.",
                dailyLife: "Avoid half-hearted commitments; ensure decisions reflect your genuine desires.",
                relationship: "Communicate to resolve misunderstandings; ignoring differences can deepen rifts.",
                job: "Recheck professional alignment; forced collaborations or unclear goals hamper success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Chariot (Reversed)",
                imageName: "chariot_reversed",
                meaning: "ATTENTION: Loss of direction, aggression, or imbalance. Overexertion leads to burnout.",
                dailyLife: "Slow down; reevaluate goals if you feel pulled in conflicting directions.",
                relationship: "Avoid bulldozing or ignoring partner’s needs; balanced compromise is vital.",
                job: "Control scattered energy; refine strategies before forging ahead blindly.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Strength (Reversed)",
                imageName: "strength_reversed",
                meaning: "ATTENTION: Self-doubt, impulsiveness, or fear. You may be underestimating your resilience.",
                dailyLife: "Resist panic or rash reactions; gather courage through mindful self-talk.",
                relationship: "Address insecurities openly; unchanneled frustration can strain bonds.",
                job: "Push through professional challenges calmly; avoid letting stress erode confidence.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hermit (Reversed)",
                imageName: "hermit_reversed",
                meaning: "ATTENTION: Excessive isolation or avoidance. Disconnection may hamper personal growth.",
                dailyLife: "Engage with supportive communities; moderate solitude with healthy social contact.",
                relationship: "Over-withdrawal can hurt intimacy; share your inner world to maintain closeness.",
                job: "Seek collaboration or mentorship; working alone indefinitely can stall progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Wheel of Fortune (Reversed)",
                imageName: "wheeloffortune_reversed",
                meaning: "ATTENTION: Resisting change or feeling stuck in a cycle. Adaptability is crucial.",
                dailyLife: "Accept life’s ebbs and flows; forcing control leads to frustration.",
                relationship: "Embrace evolving relationship dynamics; clinging to old patterns fosters conflict.",
                job: "Stay flexible; refusing new opportunities can stall professional growth.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Justice (Reversed)",
                imageName: "justice_reversed",
                meaning: "ATTENTION: Imbalance, unfairness, or dishonesty. Hidden biases may skew judgment.",
                dailyLife: "Rectify any moral oversights; ignoring truth fosters unresolved guilt or chaos.",
                relationship: "Communicate openly to correct misunderstandings; hush-ups lead to resentments.",
                job: "Ensure ethical conduct; cutting corners or favoritism eventually backfires.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Hanged Man (Reversed)",
                imageName: "hangedman_reversed",
                meaning: "ATTENTION: Resistance to letting go or stagnation. Clinging to old habits blocks insight.",
                dailyLife: "Release rigid viewpoints; forced control stifles growth and deeper understanding.",
                relationship: "Avoid sacrificing your needs blindly; healthy boundaries protect emotional well-being.",
                job: "Reevaluate stuck projects; refusing fresh perspectives hinders innovation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Death (Reversed)",
                imageName: "death_reversed",
                meaning: "ATTENTION: Fear of change or clinging to the past. Delaying endings prolongs discomfort.",
                dailyLife: "Embrace necessary transitions; resisting them may compound stress.",
                relationship: "Acknowledge when a bond needs to evolve or end; denial fosters stagnation.",
                job: "Let go of obsolete roles or methods; transformation is essential for renewal.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Temperance (Reversed)",
                imageName: "temperance_reversed",
                meaning: "ATTENTION: Imbalance or impulsiveness. Extreme behavior disrupts harmony.",
                dailyLife: "Watch out for overindulgence or chaotic routines; re-center your habits.",
                relationship: "Avoid volatile emotional swings; communication fosters stable unity.",
                job: "Check extremes in workload or approach; find synergy instead of lopsided effort.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Devil (Reversed)",
                imageName: "devil_reversed",
                meaning: "ATTENTION: Breaking free from toxic patterns. A chance to reclaim personal power.",
                dailyLife: "Identify what no longer serves you; release harmful attachments or addictions.",
                relationship: "End codependency or manipulative cycles; strive for honest, healthy dynamics.",
                job: "Refuse unethical shortcuts; move away from stifling or negative professional ties.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Tower (Reversed)",
                imageName: "tower_reversed",
                meaning: "ATTENTION: Avoidance of necessary change. Delaying upheaval prolongs instability.",
                dailyLife: "Confront issues before they escalate; clinging to false security leads to crisis.",
                relationship: "Openly address cracks in the foundation; denial heightens eventual fallout.",
                job: "Reassess precarious work situations; small adjustments now prevent larger collapses.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Star (Reversed)",
                imageName: "star_reversed",
                meaning: "ATTENTION: Discouragement or disconnection. Reignite hope to overcome negativity.",
                dailyLife: "Combat pessimism by celebrating small wins; rekindle faith in your potential.",
                relationship: "Communicate doubts or fears; shutting down fosters emotional distance.",
                job: "Seek inspiration or mentorship; letting cynicism fester blocks progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Moon (Reversed)",
                imageName: "moon_reversed",
                meaning: "ATTENTION: Confusion, hidden fears, or deception. Seek clarity to dispel illusions.",
                dailyLife: "Face subconscious anxieties; ignoring them can lead to poor choices.",
                relationship: "Speak honestly about concerns; unspoken issues create misunderstandings.",
                job: "Be wary of unclear instructions or shady dealings; clarify details to avoid pitfalls.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The Sun (Reversed)",
                imageName: "sun_reversed",
                meaning: "ATTENTION: Overexposure or fleeting success. Maintain realism amid enthusiasm.",
                dailyLife: "Don’t let overconfidence blind you; balance optimism with practical checks.",
                relationship: "Beware of taking happiness for granted; consistent effort keeps love thriving.",
                job: "Avoid complacency after small wins; remain focused on sustainable achievements.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Judgement (Reversed)",
                imageName: "judgement_reversed",
                meaning: "ATTENTION: Self-doubt, regret, or avoidance of reflection. Resist ignoring past lessons.",
                dailyLife: "Revisit mistakes openly; avoiding self-examination stalls personal growth.",
                relationship: "Unresolved issues or guilt hamper closeness; honest discussion fosters healing.",
                job: "Reflect on professional missteps; adapt strategies to prevent repeating patterns.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "The World (Reversed)",
                imageName: "world_reversed",
                meaning: "ATTENTION: Delays, incompletion, or loose ends. Address unresolved matters before moving on.",
                dailyLife: "Tie up lingering tasks or goals; ignoring them keeps you stuck in a loop.",
                relationship: "Conclude past emotional baggage; partial closure hinders progress in love.",
                job: "Finish projects thoroughly; half-done work undermines your reputation and growth.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Wands Upright
            TarotCard(
                name: "Ace of Wands",
                imageName: "ace_wands",
                meaning: "Spark of inspiration and creative energy. A burst of enthusiasm for new ventures.",
                dailyLife: "Initiate exciting projects or hobbies; channel passion into daily routines.",
                relationship: "Express spontaneity and fresh ideas; revitalize connections with shared enthusiasm.",
                job: "Take initiative with innovative concepts; be bold in pitching creative solutions.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Wands",
                imageName: "two_wands",
                meaning: "Planning and foresight. Evaluating future paths with confidence.",
                dailyLife: "Organize daily tasks effectively; set short- and long-term goals to stay on track.",
                relationship: "Collaborate on shared visions; mutual planning strengthens emotional bonds.",
                job: "Strategize career moves; consider partnerships or expansions carefully.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Wands",
                imageName: "three_wands",
                meaning: "Expansion and growth. Your efforts begin to show tangible progress.",
                dailyLife: "Look ahead for broader possibilities; step beyond comfort zones for self-improvement.",
                relationship: "Encourage collaborative growth; supporting each other's ambitions fosters unity.",
                job: "Pursue opportunities for advancement; your foundational work now yields returns.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Wands",
                imageName: "four_wands",
                meaning: "Celebration and stability. A sense of homecoming or communal joy.",
                dailyLife: "Appreciate milestones; create uplifting spaces for friends and family.",
                relationship: "Strengthen bonds with shared activities; celebrate love and unity.",
                job: "Build a secure foundation; relish team successes and supportive environments.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Wands",
                imageName: "five_wands",
                meaning: "Challenge and competition. Conflicts can lead to growth if handled constructively.",
                dailyLife: "Face minor disputes calmly; healthy debate refines your perspectives.",
                relationship: "Navigate differing opinions fairly; harness tension for deeper understanding.",
                job: "Turn challenges into growth opportunities; competition can spark innovation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Wands",
                imageName: "six_wands",
                meaning: "Victory and recognition. Public or personal success earned through dedication.",
                dailyLife: "Celebrate achievements confidently; share positivity with those who supported you.",
                relationship: "Share your triumphs; mutual pride strengthens emotional connections.",
                job: "Leverage professional wins for further growth; remain gracious in success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Wands",
                imageName: "seven_wands",
                meaning: "Perseverance and defense. Stand firm for your beliefs and progress.",
                dailyLife: "Maintain determination under pressure; your resolve can outlast challenges.",
                relationship: "Assert boundaries respectfully; protect your emotional well-being.",
                job: "Defend ideas with confidence; consistent effort overcomes opposition.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Wands",
                imageName: "eight_wands",
                meaning: "Swift action and movement. Events accelerate, requiring quick decisions.",
                dailyLife: "Act promptly on emerging opportunities; adapt to fast-paced changes.",
                relationship: "Communicate effectively; direct, honest words strengthen intimacy quickly.",
                job: "Pursue career moves or tasks with urgency; momentum is on your side.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Wands",
                imageName: "nine_wands",
                meaning: "Resilience and persistence. Final challenges test your resolve.",
                dailyLife: "Guard your energy; you’re close to completing a demanding cycle.",
                relationship: "Protect your boundaries; stand firm in your emotional truths.",
                job: "Push through professional obstacles; your perseverance ensures eventual success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Wands",
                imageName: "ten_wands",
                meaning: "Burden and responsibility. Heavy workloads require careful management.",
                dailyLife: "Recognize when you’re overwhelmed; delegate or reorganize to avoid burnout.",
                relationship: "Share emotional loads; leaning on each other fosters deeper support.",
                job: "Distribute tasks wisely; lighten your load for sustained productivity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Wands",
                imageName: "page_wands",
                meaning: "Curiosity and exploration. Embrace learning and a thirst for new experiences.",
                dailyLife: "Follow your passions spontaneously; each day can spark discovery.",
                relationship: "Express enthusiasm and sincerity; share creative or adventurous ideas together.",
                job: "Explore fresh approaches or training; an eager mindset opens doors.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Wands",
                imageName: "knight_wands",
                meaning: "Adventure and dynamic action. Bold moves can yield excitement and progress.",
                dailyLife: "Pursue goals passionately; balance impulsiveness with a hint of caution.",
                relationship: "Bring energy and excitement; let confidence kindle deeper attraction.",
                job: "Take bold steps in your professional life; remain flexible for rapid changes.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Wands",
                imageName: "queen_wands",
                meaning: "Passion and warmth. Radiate creativity and leadership with a generous spirit.",
                dailyLife: "Share your enthusiasm; your confidence can inspire those around you.",
                relationship: "Offer heartfelt care; express your feelings openly to strengthen bonds.",
                job: "Lead with innovative ideas; encourage teamwork and passion in the workplace.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Wands",
                imageName: "king_wands",
                meaning: "Leadership and vision. Channel charisma and strategic thinking to guide others.",
                dailyLife: "Direct your energy towards purposeful goals; inspire those who look up to you.",
                relationship: "Demonstrate integrity and initiative; a stable presence fosters trust.",
                job: "Steer your professional life boldly; combine big-picture thinking with decisive action.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Wands Reversed
            TarotCard(
                name: "Ace of Wands (Reversed)",
                imageName: "ace_wands_reversed",
                meaning: "ATTENTION: Delays or missed opportunities. Stagnation in creative energy or motivation.",
                dailyLife: "Push through lethargy; reignite passion by setting small achievable goals.",
                relationship: "Avoid letting excitement fizzle; communicate your needs before apathy sets in.",
                job: "Address creative blocks promptly; procrastination can erode potential breakthroughs.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Wands (Reversed)",
                imageName: "two_wands_reversed",
                meaning: "ATTENTION: Indecision and fear of change; overthinking may lead to paralysis.",
                dailyLife: "Break larger tasks into steps; over-analysis can hinder progress.",
                relationship: "Clarify mutual intentions; reluctance to commit fosters uncertainty.",
                job: "Set realistic timelines; refusing to act on ideas leads to lost momentum.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Wands (Reversed)",
                imageName: "three_wands_reversed",
                meaning: "ATTENTION: Obstacles and delays hamper expansion; stay flexible and adaptable.",
                dailyLife: "Revise plans if you hit a roadblock; forced progress invites frustration.",
                relationship: "Resolve external pressures or misunderstandings that slow mutual growth.",
                job: "Remain open to new routes if your initial strategy stalls.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Wands (Reversed)",
                imageName: "four_wands_reversed",
                meaning: "ATTENTION: Instability or disrupted celebrations. Unresolved tensions hinder harmony.",
                dailyLife: "Identify root causes of discontent; address them before they escalate.",
                relationship: "Work on emotional security; partial commitment dampens potential joy.",
                job: "Team or structural issues might undermine success; restore unity with clear communication.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Wands (Reversed)",
                imageName: "five_wands_reversed",
                meaning: "ATTENTION: Unresolved conflict or avoidance. Tension lingers if not confronted.",
                dailyLife: "Address disputes diplomatically; burying issues prolongs stress.",
                relationship: "Encourage honest dialogue; superficial harmony can mask deeper rifts.",
                job: "Seek constructive compromise; ignoring friction erodes team cohesion.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Wands (Reversed)",
                imageName: "six_wands_reversed",
                meaning: "ATTENTION: Excessive need for validation or fear of failure. Confidence wavers.",
                dailyLife: "Balance pride with humility; avoid basing self-worth solely on external praise.",
                relationship: "Share achievements without overshadowing your partner; mutual respect is key.",
                job: "Stay grounded in success or defeat; learning from each outcome fosters resilience.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Wands (Reversed)",
                imageName: "seven_wands_reversed",
                meaning: "ATTENTION: Feeling overwhelmed or overly defensive. Reassess strategies calmly.",
                dailyLife: "Seek support if burdens grow too heavy; a lone battle can exhaust you.",
                relationship: "Avoid pushing loved ones away; communicate stress or fears to find solutions.",
                job: "Reevaluate your stance; sometimes stepping back or compromising is beneficial.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Wands (Reversed)",
                imageName: "eight_wands_reversed",
                meaning: "ATTENTION: Scattered energy and delays. Impatience may cause mistakes.",
                dailyLife: "Regroup priorities; slow, steady actions beat frantic, unfocused attempts.",
                relationship: "Clarify messages; miscommunications can stall emotional progress.",
                job: "Streamline tasks; too many directions hamper real advancement.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Wands (Reversed)",
                imageName: "nine_wands_reversed",
                meaning: "ATTENTION: Risk of burnout or excessive defensiveness. Tension builds unaddressed.",
                dailyLife: "Conserve energy; reevaluate if pushing forward is wise or if rest is needed.",
                relationship: "Walls may be too high; let trusted partners in to share burdens.",
                job: "Stubbornly soldiering on can lead to collapse; delegate or pivot to manage stress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Wands (Reversed)",
                imageName: "ten_wands_reversed",
                meaning: "ATTENTION: Overwhelm or refusal to lighten burdens. Overcommitment stifles progress.",
                dailyLife: "Identify tasks you can release or postpone; refusing help prolongs struggle.",
                relationship: "Share emotional weight; isolation fosters resentment and fatigue.",
                job: "Let go of nonessential responsibilities; focus on priorities to avoid burnout.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Wands (Reversed)",
                imageName: "page_wands_reversed",
                meaning: "ATTENTION: Impulsiveness or lack of direction. Energy wasted without a clear plan.",
                dailyLife: "Tame restlessness; transform scattered curiosity into purposeful exploration.",
                relationship: "Avoid flakiness; honest communication prevents misunderstandings and hurt feelings.",
                job: "Channel enthusiasm with discipline; half-baked ideas lead to dead ends.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Wands (Reversed)",
                imageName: "knight_wands_reversed",
                meaning: "ATTENTION: Rash decisions and scattered focus. Overeagerness can sabotage outcomes.",
                dailyLife: "Pace yourself; impulsive leaps may cause unnecessary detours or risks.",
                relationship: "Beware of hot-and-cold behavior; consistent effort builds stable intimacy.",
                job: "Plan carefully; a chaotic approach undermines your potential success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Wands (Reversed)",
                imageName: "queen_wands_reversed",
                meaning: "ATTENTION: Jealousy, insecurity, or stifled creativity. Overcontrol dampens warmth.",
                dailyLife: "Rebuild confidence by recognizing your unique strengths; compare less, create more.",
                relationship: "Avoid possessive tendencies; trust fosters genuine affection and mutual freedom.",
                job: "Check negative self-talk; let go of ego battles and focus on collaboration.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Wands (Reversed)",
                imageName: "king_wands_reversed",
                meaning: "ATTENTION: Domineering or impulsive leadership. Arrogance hinders genuine respect.",
                dailyLife: "Balance ambition with empathy; dismissing others’ input isolates you.",
                relationship: "Avoid steamrolling loved ones; a partnership thrives on equality, not control.",
                job: "Use authority responsibly; reckless decisions or prideful outbursts harm progress.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Cups Upright
            TarotCard(
                name: "Ace of Cups",
                imageName: "ace_cups",
                meaning: "New love and emotional fulfillment. A fresh surge of compassion or creativity.",
                dailyLife: "Open your heart to new emotional experiences; let kindness guide your actions.",
                relationship: "Express genuine affection and empathy; budding romance or deeper intimacy awaits.",
                job: "Use emotional insight to guide decisions; personal passion fosters rewarding outcomes.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Cups",
                imageName: "two_cups",
                meaning: "Partnership and harmony. A meeting of hearts or minds fosters unity.",
                dailyLife: "Foster balanced interactions in everyday life; aim for respectful collaboration.",
                relationship: "Cultivate mutual respect and deep connection; shared goals strengthen love.",
                job: "Work well with partners or colleagues; synergy leads to collective success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Cups",
                imageName: "three_cups",
                meaning: "Celebration and friendship. Joyful gatherings highlight community bonds.",
                dailyLife: "Enjoy social moments; celebrate small victories with supportive friends.",
                relationship: "Strengthen bonds through shared celebrations or group activities.",
                job: "Utilize teamwork; positive group dynamics spark creativity and morale.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Cups",
                imageName: "four_cups",
                meaning: "Contemplation and reevaluation. Feeling unmotivated or bored invites reflection.",
                dailyLife: "Reflect on your routine; find fresh motivation or shift perspectives.",
                relationship: "Practice gratitude to avoid taking loved ones for granted.",
                job: "Consider new opportunities if current tasks feel stagnant; reevaluate your direction.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Cups",
                imageName: "five_cups",
                meaning: "Loss and reflection. Disappointment can lead to emotional growth if processed.",
                dailyLife: "Acknowledge sadness but seek lessons; hope remains in what still stands.",
                relationship: "Work toward healing; open communication fosters forgiveness and closure.",
                job: "Reevaluate strategies after setbacks; adapt to bounce back stronger.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Cups",
                imageName: "six_cups",
                meaning: "Nostalgia and joyful memories. Reconnecting with the past can bring comfort.",
                dailyLife: "Cherish positive recollections but balance them with present goals.",
                relationship: "Revisit shared experiences or childhood bonds; sweet nostalgia rekindles warmth.",
                job: "Let past successes inspire future endeavors; remain open to collaborative synergy.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Cups",
                imageName: "seven_cups",
                meaning: "Choices and dreams. Many possibilities beckon, but clarity is needed.",
                dailyLife: "Evaluate your options carefully; daydreams require practical steps to manifest.",
                relationship: "Communicate openly to align expectations; illusions can breed disappointment.",
                job: "Set realistic goals from varied ideas; avoid scattering energy across too many tasks.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Cups",
                imageName: "eight_cups",
                meaning: "Seeking deeper meaning. Walking away from unfulfilling situations.",
                dailyLife: "Leave behind what no longer serves your growth; aim for genuine satisfaction.",
                relationship: "Assess emotional investments; letting go can be an act of self-respect.",
                job: "Pursue work that resonates with your values; it may be time for a transition.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Cups",
                imageName: "nine_cups",
                meaning: "Contentment and satisfaction. A sense of personal fulfillment or wish granted.",
                dailyLife: "Appreciate small joys daily; cultivate gratitude for what you’ve achieved.",
                relationship: "Celebrate harmonious bonds; share emotional abundance with loved ones.",
                job: "Enjoy the fruits of your labor; recognition or rewards highlight your efforts.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Cups",
                imageName: "ten_cups",
                meaning: "Family and lasting happiness. Emotional harmony and a sense of belonging.",
                dailyLife: "Embrace the warmth of home and supportive communities; let love flow freely.",
                relationship: "Foster loving, supportive connections; share future dreams with optimism.",
                job: "Build a secure foundation for your future; personal fulfillment boosts career satisfaction.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Cups",
                imageName: "page_cups",
                meaning: "Creative expression and sensitivity. A gentle, imaginative spirit fosters new emotional insights.",
                dailyLife: "Explore new artistic or emotional outlets; remain open-hearted in daily interactions.",
                relationship: "Show genuine care and openness; let empathy guide your bond’s development.",
                job: "Infuse creativity into your work; a fresh perspective can spark new opportunities.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Cups",
                imageName: "knight_cups",
                meaning: "Romance and idealism. A pursuit of heartfelt dreams or relationships.",
                dailyLife: "Follow your passions with sincerity; express affection or appreciation freely.",
                relationship: "Engage in heartfelt connections; grand gestures or emotional depth may surface.",
                job: "Let passion guide professional choices; creative or humanitarian work may appeal.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Cups",
                imageName: "queen_cups",
                meaning: "Emotional balance and empathy. Offer warmth and intuitive support.",
                dailyLife: "Prioritize self-care and maintain an empathetic approach to others’ struggles.",
                relationship: "Nurture emotional well-being; show deep compassion for partners or family.",
                job: "Use your insight to navigate challenges; a caring leadership style fosters loyalty.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Cups",
                imageName: "king_cups",
                meaning: "Emotional wisdom and diplomacy. Calm guidance steadies turbulent waters.",
                dailyLife: "Keep a balanced emotional outlook; respond thoughtfully rather than reactively.",
                relationship: "Lead with compassion and understanding; be a pillar of emotional stability.",
                job: "Make thoughtful decisions; harness empathy to resolve conflicts and unify teams.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Cups Reversed
            TarotCard(
                name: "Ace of Cups (Reversed)",
                imageName: "ace_cups_reversed",
                meaning: "ATTENTION: Emotional blockage or emptiness. Over-sensitivity can create distance.",
                dailyLife: "Confront bottled-up feelings; find healthy outlets to restore emotional flow.",
                relationship: "Discuss withheld emotions; ignoring them leads to disconnection or resentment.",
                job: "Rekindle passion for your tasks; detachment can undermine motivation and creativity.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Cups (Reversed)",
                imageName: "two_cups_reversed",
                meaning: "ATTENTION: Imbalance or misaligned values. Disharmony arises if left unaddressed.",
                dailyLife: "Acknowledge internal conflicts; strive for self-consistency in daily decisions.",
                relationship: "Resolve misunderstandings promptly; neglect fosters tension or breakup.",
                job: "Realign collaborative efforts; unspoken discord blocks progress and synergy.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Cups (Reversed)",
                imageName: "three_cups_reversed",
                meaning: "ATTENTION: Overindulgence, gossip, or insincerity. Superficial bonds hinder true support.",
                dailyLife: "Balance social life with moderation; avoid drama or excessive partying.",
                relationship: "Address rumors or jealousy directly; authenticity fosters healthier connections.",
                job: "Stay professional; cliques or idle talk damage teamwork and reputation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Cups (Reversed)",
                imageName: "four_cups_reversed",
                meaning: "ATTENTION: Apathy or missed opportunities. Prolonged disengagement stifles potential.",
                dailyLife: "Seek fresh motivation; break free from complacency through small, purposeful actions.",
                relationship: "Reopen lines of communication; ignoring emotional needs fosters distance.",
                job: "Stay alert to new possibilities; letting disinterest linger forfeits career growth.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Cups (Reversed)",
                imageName: "five_cups_reversed",
                meaning: "ATTENTION: Lingering on past regrets. Slow to heal or move forward.",
                dailyLife: "Focus on recovery and acceptance; release sorrow that blocks present joy.",
                relationship: "Mend emotional wounds; forgiveness fosters reconciliation or a healthy closure.",
                job: "Learn from mistakes; excessive dwelling stalls progress and morale.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Cups (Reversed)",
                imageName: "six_cups_reversed",
                meaning: "ATTENTION: Stuck in the past or unrealistic nostalgia. Growth stalls without present focus.",
                dailyLife: "Appreciate good memories but avoid idealizing them to escape current realities.",
                relationship: "Move beyond old patterns; holding onto outdated dynamics hinders emotional maturity.",
                job: "Combine past experience with forward thinking; purely retrospective thinking impedes innovation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Cups (Reversed)",
                imageName: "seven_cups_reversed",
                meaning: "ATTENTION: Confusion or scattered goals. Narrow your focus for real progress.",
                dailyLife: "Declutter mental chaos; pick a concrete direction rather than chasing illusions.",
                relationship: "Communicate intentions clearly; misaligned fantasies lead to disappointment.",
                job: "Consolidate your plans; indefinite ambition without execution accomplishes little.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Cups (Reversed)",
                imageName: "eight_cups_reversed",
                meaning: "ATTENTION: Fear of change or stagnation. Hesitation to leave an unfulfilling situation.",
                dailyLife: "Acknowledge dissatisfaction; procrastinating departure prolongs discomfort.",
                relationship: "Confront emotional discontent; half-hearted involvement strains intimacy.",
                job: "Don’t cling to a fruitless role; weigh the cost of inaction vs. potential renewal.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Cups (Reversed)",
                imageName: "nine_cups_reversed",
                meaning: "ATTENTION: Overindulgence or superficial satisfaction. True fulfillment remains elusive.",
                dailyLife: "Seek deeper meaning behind pleasures; avoid fleeting highs that mask emptiness.",
                relationship: "Balance self-gratification with genuine empathy; superficial affection can erode trust.",
                job: "Don’t let complacency stall growth; set new goals after initial achievements.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Cups (Reversed)",
                imageName: "ten_cups_reversed",
                meaning: "ATTENTION: Unmet expectations or strained family bonds. Cracks in harmony need repair.",
                dailyLife: "Address underlying tensions; forced smiles hide deeper conflicts.",
                relationship: "Heal broken promises or emotional distance; open dialogue fosters renewed unity.",
                job: "Align personal values with professional goals; dissatisfaction may lurk beneath success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Cups (Reversed)",
                imageName: "page_cups_reversed",
                meaning: "ATTENTION: Emotional immaturity or insecurity. Fear of vulnerability stalls growth.",
                dailyLife: "Nurture self-confidence; ignoring your feelings can stunt personal development.",
                relationship: "Express concerns calmly; internalizing doubts fosters misunderstandings.",
                job: "Refine your approach; an over-sensitive reaction to criticism hampers professional growth.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Cups (Reversed)",
                imageName: "knight_cups_reversed",
                meaning: "ATTENTION: Unrealistic expectations or moodiness. Over-romanticizing leads to letdowns.",
                dailyLife: "Balance dreams with reality; avoid letting shifting emotions dictate every action.",
                relationship: "Communicate emotional fluctuations; unpredictability strains trust.",
                job: "Ground creative visions in practicality; wild swings in enthusiasm disrupt progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Cups (Reversed)",
                imageName: "queen_cups_reversed",
                meaning: "ATTENTION: Emotional instability or dependency. Neglecting self-care undermines well-being.",
                dailyLife: "Reestablish healthy boundaries; extreme self-sacrifice can deplete your energy.",
                relationship: "Express feelings openly but avoid manipulative or clingy behavior.",
                job: "Stay balanced; letting emotions override logic can hamper professional credibility.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Cups (Reversed)",
                imageName: "king_cups_reversed",
                meaning: "ATTENTION: Moodiness or emotional manipulation. Strive for clarity and balanced judgment.",
                dailyLife: "Avoid passive-aggressive tactics; own your feelings and handle conflicts directly.",
                relationship: "Instability or repressed anger can erode trust; communicate maturely.",
                job: "Maintain professionalism under stress; emotional outbursts damage leadership image.",
                reversedMeaning: ""
            ),
            // MARK: Minor Arcana – Swords Upright

            TarotCard(
                name: "Ace of Swords",
                imageName: "ace_swords",
                meaning: "Clarity and breakthrough. A new idea or perspective offers a fresh start.",
                dailyLife: "Embrace clear thinking and decisive action. Overcoming confusion can bring mental relief.",
                relationship: "Communicate your truth effectively. Honest discussions can cut through tension.",
                job: "Innovate with sharp ideas. Use logical analysis to streamline processes and strategies.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Two of Swords",
                imageName: "two_swords",
                meaning: "Decision and balance. You may feel stuck between two choices, requiring objectivity and calm.",
                dailyLife: "Make balanced choices in your routine. Carefully weighing pros and cons reduces indecision.",
                relationship: "Engage in fair dialogue. Listening to each other fosters mutual understanding and respect.",
                job: "Assess your options carefully. Neutral evaluation leads to a more stable path forward.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Three of Swords",
                imageName: "three_swords",
                meaning: "Heartbreak and healing. Emotional pain can lead to deeper self-awareness if faced bravely.",
                dailyLife: "Process emotional pain and learn from setbacks. Acknowledging sadness is the first step to recovery.",
                relationship: "Address hurt feelings openly. Honest conversations can pave the way for forgiveness or closure.",
                job: "Improve future decisions from past lessons. Failure can be a powerful teacher when acknowledged.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Four of Swords",
                imageName: "four_swords",
                meaning: "Rest and recovery. Stepping back to restore your energy helps you return stronger.",
                dailyLife: "Take time for self-care and rejuvenation. Quiet moments can reduce stress and prevent burnout.",
                relationship: "Give space for healing. Emotional distance can sometimes help individuals gain clarity.",
                job: "Reassess your goals with a fresh perspective. A short break can spark renewed motivation.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Five of Swords",
                imageName: "five_swords",
                meaning: "Conflict and resolution. Tension may linger if handled poorly, but honesty can mend fences.",
                dailyLife: "Address conflicts with calm. A willingness to compromise can salvage relationships or tasks.",
                relationship: "Strive for peaceful communication. Admitting mistakes can rebuild trust and respect.",
                job: "Resolve disputes with clarity. Transparent dialogue prevents misunderstandings from escalating.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Six of Swords",
                imageName: "six_swords",
                meaning: "Transition and moving on. A shift in perspective or environment can bring relief and hope.",
                dailyLife: "Embrace change and leave behind what no longer serves you. Emotional baggage can be released.",
                relationship: "Communicate needed changes. Sometimes relocation or a fresh start helps a partnership thrive.",
                job: "Seek new opportunities to advance. A proactive approach to transitions leads to smoother outcomes.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Seven of Swords",
                imageName: "seven_swords",
                meaning: "Strategy and subtlety. Caution is needed to navigate tricky situations without harm.",
                dailyLife: "Plan your actions with care. A thoughtful approach prevents unintended consequences.",
                relationship: "Be honest and direct. Secrets or hidden agendas erode trust in close connections.",
                job: "Utilize strategic thinking in your pursuits. Discretion can be valuable, but maintain integrity.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Eight of Swords",
                imageName: "eight_swords",
                meaning: "Restriction and challenge. Self-imposed limitations may be the biggest barriers you face.",
                dailyLife: "Identify self-imposed limits and work to overcome them. Sometimes your mindset is the key obstacle.",
                relationship: "Communicate boundaries clearly. Feeling trapped can be eased by open dialogue and support.",
                job: "Seek solutions to obstacles. Consider whether fear is holding you back from exploring better roles.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Nine of Swords",
                imageName: "nine_swords",
                meaning: "Anxiety and worry. Negative thoughts can amplify stress, so address concerns head-on.",
                dailyLife: "Acknowledge your fears and seek calm. Journaling or talking to a friend can alleviate mental burdens.",
                relationship: "Share concerns with trusted ones. Opening up helps you realize you’re not alone in your worries.",
                job: "Address stressors affecting your work. Clear communication can resolve many anxieties and conflicts.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Ten of Swords",
                imageName: "ten_swords",
                meaning: "Endings and release. A difficult cycle concludes, allowing space for renewal.",
                dailyLife: "Accept the end of a cycle and move on. Recognize that closure can lead to fresh beginnings.",
                relationship: "Heal from past hurts. Honest acknowledgment of pain can pave the way for forgiveness or new starts.",
                job: "Rebuild with new strategies. A significant failure can become the foundation for smarter decisions.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Page of Swords",
                imageName: "page_swords",
                meaning: "Curiosity and vigilance. A thirst for knowledge drives you to ask questions and observe keenly.",
                dailyLife: "Stay alert and open to new ideas. Embrace learning experiences that sharpen your intellect.",
                relationship: "Communicate clearly and listen actively. A curious, understanding approach fosters intimacy.",
                job: "Apply innovative ideas in your environment. Research and fresh perspectives lead to progress.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Knight of Swords",
                imageName: "knight_swords",
                meaning: "Action and assertiveness. Quick thinking and bold moves can propel you forward.",
                dailyLife: "Take decisive steps and be bold. Don’t let fear stall your progress when the path is clear.",
                relationship: "Express your views honestly. Passionate communication can bring excitement or clarity.",
                job: "Drive forward with confidence. Swift action and clarity of purpose can secure vital opportunities.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Queen of Swords",
                imageName: "queen_swords",
                meaning: "Clarity and independence. Combine honesty with empathy to handle challenges effectively.",
                dailyLife: "Maintain clear thoughts and articulate ideas. Logic and emotional intelligence go hand in hand.",
                relationship: "Value honesty and direct communication. Being straightforward avoids confusion and builds respect.",
                job: "Strategize with intellect. Your keen insights help solve complex problems and guide decisions.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "King of Swords",
                imageName: "king_swords",
                meaning: "Authority and insight. Lead with a balanced mind, applying fairness and analytical skill.",
                dailyLife: "Use analytical thinking to guide your day. Gathering facts before acting prevents missteps.",
                relationship: "Lead with fairness and truth. Clear boundaries and respect create harmony in close bonds.",
                job: "Make strategic decisions. A logical, big-picture approach fosters growth and stability.",
                reversedMeaning: ""
            ),

// MARK: Minor Arcana – Swords Reversed

            TarotCard(
                name: "Ace of Swords (Reversed)",
                imageName: "ace_swords_reversed",
                meaning: "ATTENTION: Avoid confusion and unclear intentions; work to gain mental clarity.",
                dailyLife: "Confront uncertainty by gathering facts; resisting clarity leads to prolonged mental stress.",
                relationship: "Express doubts calmly instead of harboring silent misgivings; open dialogue prevents misunderstandings.",
                job: "Identify vague goals or projects; refine your approach to avoid half-finished ideas or wasted effort.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Two of Swords (Reversed)",
                imageName: "two_swords_reversed",
                meaning: "ATTENTION: Be aware of indecision and avoidance; address uncertainties directly.",
                dailyLife: "Procrastinating choices can intensify anxiety; commit to a direction, even if imperfect.",
                relationship: "Discuss hidden conflicts; indecision about the relationship’s future fosters tension or resentment.",
                job: "Clarify roles or tasks; ignoring workplace dilemmas leaves you stuck or blindsided later.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Three of Swords (Reversed)",
                imageName: "three_swords_reversed",
                meaning: "ATTENTION: Beware of lingering sorrow and unhealed wounds; work on forgiveness.",
                dailyLife: "Acknowledge unresolved pain; bottling up grief prolongs emotional distress.",
                relationship: "Have genuine conversations about past hurts; mutual compassion can begin the healing process.",
                job: "Learn from previous failures or betrayals; refusing closure can sabotage future collaboration.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Four of Swords (Reversed)",
                imageName: "four_swords_reversed",
                meaning: "ATTENTION: Avoid burnout and constant stress; balance work with sufficient rest.",
                dailyLife: "Overextending yourself physically or mentally leads to exhaustion; schedule real downtime.",
                relationship: "Emotional fatigue erodes connection; pause conflicts or intense discussions to regroup.",
                job: "Refusing to step back from demands can trigger errors; short breaks enhance productivity.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Five of Swords (Reversed)",
                imageName: "five_swords_reversed",
                meaning: "ATTENTION: Beware of unresolved tension and regret; aim for compromise and resolution.",
                dailyLife: "Make amends or clarify past disputes; holding onto grudges prevents forward motion.",
                relationship: "Rebuild trust through sincere apologies and honest communication; let go of spite.",
                job: "Address lingering workplace resentments; open negotiation fosters a healthier environment.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Six of Swords (Reversed)",
                imageName: "six_swords_reversed",
                meaning: "ATTENTION: Avoid resistance to change and lingering attachments; remain open to new paths.",
                dailyLife: "Refusing to move on from harmful situations prolongs discomfort; release the past for peace.",
                relationship: "Unfinished emotional business weighs down progress; let go or resolve old baggage.",
                job: "Adapt to shifting professional conditions; clinging to old routines can stall career growth.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Seven of Swords (Reversed)",
                imageName: "seven_swords_reversed",
                meaning: "ATTENTION: Beware of dishonesty and underhanded tactics; maintain integrity in all dealings.",
                dailyLife: "Confront your own or others’ deceptive patterns; honesty simplifies life’s complexities.",
                relationship: "Address secrets or hidden motives; mutual trust requires transparency, not stealth.",
                job: "Avoid shady shortcuts or workplace politics; unethical maneuvers harm long-term credibility.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Eight of Swords (Reversed)",
                imageName: "eight_swords_reversed",
                meaning: "ATTENTION: Avoid feeling trapped and helpless; explore opportunities for freedom and clarity.",
                dailyLife: "Recognize self-imposed limitations; stepping outside your comfort zone dissolves many fears.",
                relationship: "Speak your concerns; silence can create emotional prisons and misunderstandings.",
                job: "Question confining roles or tasks; advocating for changes may reveal new prospects.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Nine of Swords (Reversed)",
                imageName: "nine_swords_reversed",
                meaning: "ATTENTION: Beware of excessive worry and mental distress; practice mindfulness and seek balance.",
                dailyLife: "Stop cyclical negative thoughts; therapy or stress management breaks anxiety loops.",
                relationship: "Share hidden fears before they escalate; supportive dialogue reduces feelings of isolation.",
                job: "Tackle workplace stress proactively; procrastinating on tough tasks intensifies dread.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Ten of Swords (Reversed)",
                imageName: "ten_swords_reversed",
                meaning: "ATTENTION: Avoid lingering pain and inability to move forward; seek renewal and healing.",
                dailyLife: "Stop reliving past crises; a fresh start emerges once you acknowledge and release old wounds.",
                relationship: "Discuss finalizing emotional closures; half-finished breakups or unresolved betrayals block new growth.",
                job: "Learn from a failed project or toxic environment; refusing to accept endings keeps you stuck.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Page of Swords (Reversed)",
                imageName: "page_swords_reversed",
                meaning: "ATTENTION: Beware of gossip and impulsiveness; focus on clear and honest communication.",
                dailyLife: "Curb rash comments or over-sharing; impulsive words can cause unexpected fallout.",
                relationship: "Stop fueling drama with rumors or half-truths; sincerity fosters real understanding.",
                job: "Seek facts before voicing opinions; impulsive judgments damage credibility and rapport.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Knight of Swords (Reversed)",
                imageName: "knight_swords_reversed",
                meaning: "ATTENTION: Avoid rash decisions and aggressive behavior; think before acting and maintain balance.",
                dailyLife: "Slow down; impulsive moves or angry outbursts sabotage progress and create regrets.",
                relationship: "Communicate assertively but not harshly; hasty words can wound those you care about.",
                job: "Plan thoroughly; a chaotic or confrontational approach alienates coworkers and undermines success.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "Queen of Swords (Reversed)",
                imageName: "queen_swords_reversed",
                meaning: "ATTENTION: Beware of coldness and bitterness; balance logic with empathy and warmth.",
                dailyLife: "Recognize emotional needs; constant detachment can isolate you from supportive connections.",
                relationship: "Stop using sarcasm or aloofness to shield vulnerability; it strains genuine intimacy.",
                job: "Pair intellect with diplomacy; unyielding critiques can harm team morale and cooperation.",
                reversedMeaning: ""
            ),

            TarotCard(
                name: "King of Swords (Reversed)",
                imageName: "king_swords_reversed",
                meaning: "ATTENTION: Avoid tyrannical or manipulative tendencies; strive for balanced judgment and fairness.",
                dailyLife: "Check controlling behaviors; a rigid stance alienates loved ones or stifles healthy debate.",
                relationship: "Communicate fairly; manipulative or domineering tactics destroy trust and respect.",
                job: "Use authority ethically; dismissive or oppressive leadership sparks conflict and reduces loyalty.",
                reversedMeaning: ""
            ),

            // MARK: Minor Arcana – Pentacles Upright
            TarotCard(
                name: "Ace of Pentacles",
                imageName: "ace_pentacles",
                meaning: "New opportunities and prosperity. A solid foundation for future success.",
                dailyLife: "Seize growth opportunities; small, consistent steps build lasting stability.",
                relationship: "Cultivate secure, nurturing bonds; show reliability and trustworthiness.",
                job: "Embrace fresh ventures with practical planning; handle finances responsibly.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Pentacles",
                imageName: "two_pentacles",
                meaning: "Balance and adaptability. Skillfully juggling multiple responsibilities.",
                dailyLife: "Manage daily tasks with flexibility; remain calm amidst changing priorities.",
                relationship: "Maintain harmonious give-and-take; coordinate schedules or needs effectively.",
                job: "Juggle responsibilities with agility; adapt to shifting work demands or finances.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Pentacles",
                imageName: "three_pentacles",
                meaning: "Collaboration and skill. Team efforts produce meaningful results.",
                dailyLife: "Work well with others; combine talents for more significant achievements.",
                relationship: "Foster teamwork in shared goals; mutual respect boosts closeness.",
                job: "Excel through cooperation and craftsmanship; recognition follows solid performance.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Pentacles",
                imageName: "four_pentacles",
                meaning: "Stability and security. Guard resources but avoid excessive rigidity.",
                dailyLife: "Build a solid foundation; moderate saving and spending for a balanced life.",
                relationship: "Establish clear boundaries; don’t let fear of loss stifle emotional sharing.",
                job: "Manage finances and resources carefully; remain open to strategic investments.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Pentacles",
                imageName: "five_pentacles",
                meaning: "Hardship and challenge. Seek support and remain hopeful despite adversity.",
                dailyLife: "Acknowledge struggles; look for assistance or new strategies to overcome them.",
                relationship: "Reach out in tough times; empathy and communication help rebuild closeness.",
                job: "Reevaluate challenges; pivot or seek help to regain financial or career stability.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Pentacles",
                imageName: "six_pentacles",
                meaning: "Generosity and balance. Shared resources or kindness fosters mutual growth.",
                dailyLife: "Offer help where you can; accept support graciously when needed.",
                relationship: "Fair exchanges deepen trust; reciprocate emotional or material aid.",
                job: "Aim for balanced professional dealings; philanthropic gestures can enhance reputation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Pentacles",
                imageName: "seven_pentacles",
                meaning: "Patience and long-term growth. Investments need time to bear fruit.",
                dailyLife: "Nurture daily habits; small improvements accumulate into significant progress.",
                relationship: "Cultivate steady bonds; lasting intimacy grows with consistent effort.",
                job: "Focus on long-term gains; carefully evaluate progress and adjust strategies.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Pentacles",
                imageName: "eight_pentacles",
                meaning: "Diligence and mastery. Hard work refines your craft or skills.",
                dailyLife: "Focus on honing abilities or healthy routines; dedication leads to expertise.",
                relationship: "Invest time in nurturing bonds; show genuine interest in loved ones’ growth.",
                job: "Improve professionally through dedicated practice; competence earns recognition.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Pentacles",
                imageName: "nine_pentacles",
                meaning: "Independence and luxury. Enjoy the rewards of discipline and self-reliance.",
                dailyLife: "Relish personal comfort and successes; share abundance with gratitude.",
                relationship: "Cultivate self-sufficient bonds; healthy independence enhances mutual respect.",
                job: "Secure financial or career success with prudent strategies; celebrate milestones.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Pentacles",
                imageName: "ten_pentacles",
                meaning: "Wealth and legacy. Long-term security and family well-being.",
                dailyLife: "Embrace stability; plan for the future to ensure lasting prosperity.",
                relationship: "Build enduring bonds that benefit loved ones across generations.",
                job: "Plan for sustained success; wise investments or career moves fortify your legacy.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Pentacles",
                imageName: "page_pentacles",
                meaning: "Curiosity and ambition. An eagerness to learn and improve practical skills.",
                dailyLife: "Approach tasks methodically; stay open to new knowledge and experiences.",
                relationship: "Engage in sincere, supportive connections; show you’re willing to grow together.",
                job: "Explore new opportunities with focus; consistent effort yields tangible results.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Pentacles",
                imageName: "knight_pentacles",
                meaning: "Responsibility and perseverance. Steady progress through diligent work.",
                dailyLife: "Commit to reliable routines; small steps daily ensure substantial achievement.",
                relationship: "Value loyalty and practical support; show devotion through consistent care.",
                job: "Advance steadily with disciplined effort; patience leads to strong professional standing.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Pentacles",
                imageName: "queen_pentacles",
                meaning: "Nurturing and practicality. Provide comfort, stability, and resourcefulness.",
                dailyLife: "Cultivate a balanced, secure routine; show generosity without neglecting self.",
                relationship: "Offer care and emotional warmth; create a safe haven for loved ones.",
                job: "Manage career and finances pragmatically; combine compassion with business sense.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Pentacles",
                imageName: "king_pentacles",
                meaning: "Security and success. Command material resources with balanced leadership.",
                dailyLife: "Build a solid environment; be consistent and structured in daily choices.",
                relationship: "Lead with stability and care; demonstrate reliability to strengthen trust.",
                job: "Strive for financial and career achievements with ethical, grounded strategies.",
                reversedMeaning: ""
            ),
            
            // MARK: Minor Arcana – Pentacles Reversed
            TarotCard(
                name: "Ace of Pentacles (Reversed)",
                imageName: "ace_pentacles_reversed",
                meaning: "ATTENTION: Missed opportunities or financial setbacks. Stay grounded and practical.",
                dailyLife: "Evaluate spending or saving habits; ignoring budgets can breed long-term stress.",
                relationship: "Neglecting basic stability or shared goals undermines emotional security.",
                job: "Revisit your approach to new ventures; correct oversights before they escalate.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Two of Pentacles (Reversed)",
                imageName: "two_pentacles_reversed",
                meaning: "ATTENTION: Overwhelm and disorganization. Tasks slip through the cracks without reprioritizing.",
                dailyLife: "Simplify schedules; juggling too much leads to burnout or missed obligations.",
                relationship: "Balance emotional needs; an unsteady approach strains cooperation.",
                job: "Re-manage workloads; haphazard multitasking undermines quality and reliability.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Three of Pentacles (Reversed)",
                imageName: "three_pentacles_reversed",
                meaning: "ATTENTION: Poor planning or lack of teamwork. Collaboration falters if not nurtured.",
                dailyLife: "Refine your approach; ignoring feedback or skipping preparation invites chaos.",
                relationship: "Disunity or unwillingness to cooperate damages trust and shared goals.",
                job: "Improve communication and respect; half-hearted cooperation stunts progress.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Four of Pentacles (Reversed)",
                imageName: "four_pentacles_reversed",
                meaning: "ATTENTION: Greed or rigidity. Over-clinging stifles growth and generosity.",
                dailyLife: "Open to change; hoarding resources or emotions isolates you from supportive networks.",
                relationship: "Release fear-based control; emotional withholding erodes closeness.",
                job: "Consider strategic risks; refusing to invest or share ideas blocks advancement.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Five of Pentacles (Reversed)",
                imageName: "five_pentacles_reversed",
                meaning: "ATTENTION: Isolation or financial hardship. Recovery is possible with active effort.",
                dailyLife: "Seek solutions or external help; prolonged denial worsens struggles.",
                relationship: "Reach out for empathy; healing rifts or insecurities requires mutual openness.",
                job: "Reevaluate professional pitfalls; plan a comeback strategy with resilience.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Six of Pentacles (Reversed)",
                imageName: "six_pentacles_reversed",
                meaning: "ATTENTION: Inequality or dependency. One-sided giving or taking fosters imbalance.",
                dailyLife: "Assess whether you’re overgiving or undervaluing others’ support.",
                relationship: "Mutual respect is key; resentments brew if generosity is exploited.",
                job: "Avoid exploitative deals; fairness fosters trust and long-term partnerships.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Seven of Pentacles (Reversed)",
                imageName: "seven_pentacles_reversed",
                meaning: "ATTENTION: Impatience or poor investment. Lack of perseverance hinders rewards.",
                dailyLife: "Give endeavors time to mature; expecting instant results leads to frustration.",
                relationship: "Nurture bonds steadily; pushing for quick fixes can sabotage genuine intimacy.",
                job: "Review progress realistically; impulsive changes or quitting too soon wastes prior effort.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Eight of Pentacles (Reversed)",
                imageName: "eight_pentacles_reversed",
                meaning: "ATTENTION: Lack of focus or incomplete projects. Consistency is crucial for mastery.",
                dailyLife: "Address procrastination; half-done tasks accumulate stress and hamper growth.",
                relationship: "Show up consistently; neglect or distraction undermines emotional security.",
                job: "Strive for diligence; letting quality slip or skipping details harms your reputation.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Nine of Pentacles (Reversed)",
                imageName: "nine_pentacles_reversed",
                meaning: "ATTENTION: Isolation or overindulgence. Over-fixation on material comfort can breed loneliness.",
                dailyLife: "Balance self-sufficiency with community; a purely solo approach can feel empty.",
                relationship: "Check if independence has become emotional distance; share your life’s rewards.",
                job: "Don’t let complacency block further ambition; remain connected to your team’s needs.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Ten of Pentacles (Reversed)",
                imageName: "ten_pentacles_reversed",
                meaning: "ATTENTION: Instability or discord in legacy. Long-term plans may be at risk.",
                dailyLife: "Address hidden family or financial issues; ignoring them erodes security.",
                relationship: "Misalignments over future goals or family matters need open negotiation.",
                job: "Revisit structural weaknesses in your career path; correct them for lasting success.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Page of Pentacles (Reversed)",
                imageName: "page_pentacles_reversed",
                meaning: "ATTENTION: Lack of ambition or procrastination. Unclear goals stall progress.",
                dailyLife: "Set realistic targets; drifting aimlessly fosters wasted potential.",
                relationship: "Show genuine effort; halfhearted involvement signals unreliability.",
                job: "Define career steps; letting inertia take over prevents skill development.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Knight of Pentacles (Reversed)",
                imageName: "knight_pentacles_reversed",
                meaning: "ATTENTION: Stagnation or stubborn routines. Inflexibility hampers advancement.",
                dailyLife: "Re-evaluate repetitive habits; slight changes can rekindle motivation.",
                relationship: "Rigidity or reluctance to adapt can create emotional distance.",
                job: "Modify outdated methods; clinging to old ways stalls professional growth.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "Queen of Pentacles (Reversed)",
                imageName: "queen_pentacles_reversed",
                meaning: "ATTENTION: Overprotectiveness or materialism. Neglecting emotional well-being for external security.",
                dailyLife: "Loosen control; balance nurturing others with self-care to avoid depletion.",
                relationship: "Beware of smothering or measuring love purely in material terms.",
                job: "Stay open to new ideas; obsession with safe routines can limit potential expansion.",
                reversedMeaning: ""
            ),
            TarotCard(
                name: "King of Pentacles (Reversed)",
                imageName: "king_pentacles_reversed",
                meaning: "ATTENTION: Stubbornness, greed, or misuse of resources. Arrogance undermines respect.",
                dailyLife: "Remain humble; share wealth or knowledge rather than hoarding them.",
                relationship: "Overemphasis on control or finances can alienate partners emotionally.",
                job: "Lead fairly; refusing input or clinging to personal power harms collective progress.",
                reversedMeaning: ""
            )
        ]
    }
}
