import SwiftUI

struct DeckShuffleView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 模拟 14 张卡，前 7 张在"上扇"，后 7 张在"下扇"
    @State private var deck: [String] = Array(repeating: "card_back", count: 14)
    
    // 卡片位置信息
    @State private var cardPositions: [CardPosition]
    
    // 洗牌锁
    @State private var isShuffling = false
    
    // 抽牌弹窗
    @State private var revealedCards: [String] = []
    @State private var showPopup = false
    
    // 卡片尺寸
    let cardSize = CGSize(width: 200, height: 300)
    
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
        GeometryReader { geometry in
            ZStack {
                // 背景
                Image("table")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.8))
                
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
                            .shadow(color: .black.opacity(0.4), radius: 5, x: 2, y: 2)
                            .animation(.easeInOut(duration: 0.5), value: position)
                    }
                }
                
                // Shuffle 按钮 - 放在中间
                Button {
                    performShuffle()
                } label: {
                    Text("Shuffle")
                        .font(.custom("Papyrus", size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.customGold.opacity(0.8))
                        .cornerRadius(10)
                }
                .disabled(isShuffling)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            arrangeCards()
        }
        // 抽牌弹窗
        .sheet(isPresented: $showPopup) {
            RevealCardsPopupView(cards: revealedCards) {
                showPopup = false
            }
        }
    }
    
    // MARK: - 排布扇形
    private func arrangeCards() {
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        
        let topCount = 7
        let bottomCount = 7
        
        // 上扇从 0° 到 180°，下扇从 180° 到 360°
        let topStartAngle: Double = 0
        let topEndAngle:   Double = 180
        
        let bottomStartAngle: Double = 180
        let bottomEndAngle:   Double = 360
        
        // 弧形圆心的 y 坐标
        let topCenterY = screenH * 0.05
        let bottomCenterY = screenH * 0.9
        
        // 扇形半径
        let radius: CGFloat = 200
        
        // 线性插值计算角度
        func angleFor(index: Int, total: Int, start: Double, end: Double) -> Double {
            if total < 2 { return start }
            let fraction = Double(index) / Double(total - 1)
            return start + (end - start) * fraction
        }
        
        for i in cardPositions.indices {
            let isTop = (i < topCount)
            let indexInArc = isTop ? i : i - topCount
            
            let (startDeg, endDeg, centerY) = isTop
                ? (topStartAngle, topEndAngle, topCenterY)
                : (bottomStartAngle, bottomEndAngle, bottomCenterY)
            
            // 计算该卡在弧形上的角度
            let degrees = angleFor(
                index: indexInArc,
                total: isTop ? topCount : bottomCount,
                start: startDeg,
                end: endDeg
            )
            let radians = degrees * .pi / 180
            
            // 圆心在屏幕水平中点
            let centerX = screenW * 0.5
            
            // 计算卡片中心
            let x = centerX + cos(radians) * radius
            let y = centerY + sin(radians) * radius
            
            cardPositions[i].offset = CGSize(
                width: x - screenW/2,
                height: y - screenH/2
            )
            
            // 让卡片随弧形倾斜
            cardPositions[i].rotation = .degrees(90 + degrees)
            cardPositions[i].scale = 1.0
        }
    }
    
    // MARK: - 洗牌逻辑
    private func performShuffle() {
        guard !isShuffling else { return }
        isShuffling = true
        
        // 1. 收拢成两叠
        withAnimation(.easeInOut(duration: 0.5)) {
            for i in cardPositions.indices {
                let isTop = i < 7
                cardPositions[i].offset = CGSize(
                    width: 0,
                    height: isTop ? -100 : 100
                )
                // 让它们在收拢时竖直
                cardPositions[i].rotation = .degrees(0)
                cardPositions[i].scale = 0.8
            }
        }
        
        // 2. 交换上下叠
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeInOut(duration: 0.5)) {
                for i in cardPositions.indices {
                    cardPositions[i].isTop.toggle()
                    cardPositions[i].offset = CGSize(
                        width: 0,
                        height: cardPositions[i].isTop ? -100 : 100
                    )
                }
            }
            
            // 3. 展开回扇形
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    arrangeCards()
                    for i in cardPositions.indices {
                        cardPositions[i].scale = 1.0
                    }
                }
                // 这里动画还需要 0.5 秒才结束
                // 让我们等动画结束后，再额外等 1 秒再弹窗
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // 再等 1 秒
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShuffling = false
                        // 抽 3 张牌，弹窗
                        let randomDeck = deck.shuffled()
                        revealedCards = Array(randomDeck.prefix(3))
                        showPopup = true
                    }
                }
            }
        }
    }
}

// MARK: - 卡片位置信息
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

// MARK: - 弹窗视图
struct RevealCardsPopupView: View {
    let cards: [String]
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Reading")
                .font(.custom("Papyrus", size: 24))
                .foregroundColor(.white)
                .padding()
            
            HStack(spacing: 20) {
                CardView(title: "Past", image: cards[safe: 0] ?? "card_back")
                CardView(title: "Present", image: cards[safe: 1] ?? "card_back")
                CardView(title: "Future", image: cards[safe: 2] ?? "card_back")
            }
            
            Text("These are placeholder explanations.\nThe final version will have real interpretations.")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Button(action: {
                onClose()
            }) {
                Text("Close")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.customGold)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .padding()
    }
}

// MARK: - 小卡片展示
struct CardView: View {
    let title: String
    let image: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Papyrus", size: 18))
                .foregroundColor(.white)
            
            Image(image)
                .resizable()
                .frame(width: 100, height: 150)
                .cornerRadius(10)
        }
    }
}

// MARK: - Array 安全下标
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}


// MARK: - 预览
#Preview {
    NavigationStack {
        DeckShuffleView()
    }
}
