import SwiftUI

struct DeckShuffleView: View {
    @Environment(\.dismiss) private var dismiss
    
    let deck = Array(repeating: "card_back", count: 14) // 每个扇形6张牌
    @State private var cardPositions: [CardPosition]
    @State private var isShuffling = false
    
    let cardSize = CGSize(width: 140, height: 210)
    
    init() {
        var positions: [CardPosition] = []
        for i in 0..<14 {
            let isTop = i < 7
            positions.append(CardPosition(
                index: i,
                isTop: isTop,
                offset: .zero,
                rotation: .zero,
                scale: 1.0
            ))
        }
        _cardPositions = State(initialValue: positions)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // 卡片层
            ZStack {
                ForEach(cardPositions.indices, id: \.self) { index in
                    let position = cardPositions[index]
                    
                    Image("card_back")
                        .resizable()
                        .frame(width: cardSize.width, height: cardSize.height)
                        .rotationEffect(position.rotation)
                        .scaleEffect(position.scale)
                        .offset(position.offset)
                        .animation(.easeInOut(duration: 0.5), value: position)
                }
            }
            
            // Shuffle 按钮
            VStack {
                Spacer()
                
                Button {
                    performShuffle()
                } label: {
                    Text("Shuffle")
                        .font(.custom("Papyrus", size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(Color.customGold.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
                .disabled(isShuffling)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Shuffle Cards")
                    .font(.custom("Papyrus", size: 20))
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            arrangeCards()
        }
    }
    
    private func arrangeCards() {
    // For convenience:
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height

        // We have 12 cards total, 6 for the top arc and 6 for the bottom arc.
        // We'll define angles so that the top forms a "U" and the bottom forms an "n".
        
        // —— 1) Parameters you can tweak ——
        // Arc range (in degrees) for top vs. bottom. Adjust to taste:
        let topStartAngle: Double = 0
        let topEndAngle:   Double = 180

        let bottomStartAngle: Double = 180
        let bottomEndAngle:   Double = 360

        // How “wide” the arcs should be (0 = narrower, 180 = full semicircle, etc.).
        // By default, for 6 cards we can just span the entire range from startAngle to endAngle.
        let topCount = 7
        let bottomCount = 7
        // Where to place the center of each arc
        let topCenterY = screenH * 0.1
        let bottomCenterY = screenH * 0.9
        // Radius of the semicircle
        let radius: CGFloat = 150

        // —— 2) Compute angles for top and bottom arcs ——
        // For the top 6 cards, we go from topStartAngle to topEndAngle in 5 steps (between 6 cards).
        // For the bottom 6 cards, from bottomStartAngle to bottomEndAngle in 5 steps.

        // Helper: linear interpolation in degrees
        func angleFor(index: Int, total: Int, start: Double, end: Double) -> Double {
            // e.g. for i in [0..5], we want i in [0..5] steps from start->end
            if total < 2 { return start } // fallback
            let fraction = Double(index) / Double(total - 1)
            return start + (end - start) * fraction
        }

        // —— 3) Assign positions to each card ——
        for i in cardPositions.indices {
            let isTop = (i < topCount)
            let indexInArc = isTop ? i : i - topCount

            // Decide which arc’s parameters to use
            let (startDeg, endDeg, centerY) = isTop
                ? (topStartAngle, topEndAngle, topCenterY)
                : (bottomStartAngle, bottomEndAngle, bottomCenterY)

            // Angle in degrees for this card
            let degrees = angleFor(
                index: indexInArc,
                total: isTop ? topCount : bottomCount,
                start: startDeg,
                end: endDeg
            )
            let radians = degrees * .pi / 180

            // The arc center is horizontally at mid-screen
            let centerX = screenW * 0.5

            // Compute x/y by offsetting from the center
            let x = centerX + cos(radians) * radius
            let y = centerY + sin(radians) * radius

            // Store offset relative to screen center
            cardPositions[i].offset = CGSize(
                width: x - screenW/2,
                height: y - screenH/2
            )

            // Keep card vertical by rotating 90°, then add the arc’s own angle
            // so that the card edges follow the arc.
            cardPositions[i].rotation = .degrees(90 + degrees)
            cardPositions[i].scale = 1.0
        }
    }
    
    private func performShuffle() {
        guard !isShuffling else { return }
        isShuffling = true
        
        // 1. 收起成两叠
        withAnimation(.easeInOut(duration: 0.5)) {
            for i in cardPositions.indices {
                let isTop = i < 6
                cardPositions[i].offset = CGSize(
                    width: 0,
                    height: isTop ? -100 : 100
                )
                // 修改这里 - 保持卡片竖直
                cardPositions[i].rotation = .degrees(isTop ? 0 : 270)
                cardPositions[i].scale = 0.8
            }
        }
        
        // 2. 交换位置
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut(duration: 0.5)) {
                // 两叠牌交换位置
                for i in cardPositions.indices {
                    cardPositions[i].isTop.toggle()
                    cardPositions[i].offset = CGSize(
                        width: 0,
                        height: cardPositions[i].isTop ? -100 : 100
                    )
                }
            }
            
            // 3. 展开成扇形
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    arrangeCards()
                    for i in cardPositions.indices {
                        cardPositions[i].scale = 1.0
                    }
                }
                isShuffling = false
            }
        }
    }
}

// 用于追踪每张卡片状态的结构体
struct CardPosition: Equatable {
    var index: Int
    var isTop: Bool
    var offset: CGSize
    var rotation: Angle
    var scale: CGFloat
    
    static func == (lhs: CardPosition, rhs: CardPosition) -> Bool {
        lhs.index == rhs.index &&
        lhs.isTop == rhs.isTop &&
        lhs.offset == rhs.offset &&
        lhs.rotation == rhs.rotation &&
        lhs.scale == rhs.scale
    }
}
