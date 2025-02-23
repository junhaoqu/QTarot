import SwiftUI

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

struct DeckShuffleView: View {
    @Environment(\.dismiss) private var dismiss
    
    let mode: ReadingMode
    @Binding var question: String
    
    // 模拟 14 张卡，前 7 张在 "上扇"，后 7 张在 "下扇"
    @State private var deck: [TarotCard] = []
    
    // 卡片位置信息
    @State private var cardPositions: [CardPosition]
    
    // 洗牌锁
    @State private var isShuffling = false
    
    // 洗牌后抽出的 3 张牌
    @State private var revealedCards: [TarotCard] = []
    
    // 卡片尺寸
    let cardSize = CGSize(width: 200, height: 300)
    
    // Add this state variable near the top with other @State properties
    @State private var shouldShowReading = false
    
    init(mode: ReadingMode, question: Binding<String>) {
        print("DeckShuffleView initialized with question: \(question.wrappedValue)")
        self.mode = mode
        _question = question
        // 初始化卡片位置
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
                
                // Shuffle 按钮
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("Back")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            loadDeck()
            arrangeCards()
        }
        // Replace the navigationDestination with a navigation link
        .background(
            NavigationLink(
                destination: ThreeCardReadingView(cards: revealedCards, mode: mode, question: question),
                isActive: $shouldShowReading
            ) { EmptyView() }
        )
    }
    
    // MARK: - 加载真实塔罗牌
    private func loadDeck() {
        let fullDeck = TarotDeck.shared.cards
        deck = Array(fullDeck.shuffled().prefix(14))
    }
    
    // MARK: - 排布扇形
    private func arrangeCards() {
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        
        let topCount = 7
        let bottomCount = 7
        
        // 上扇从 0° 到 180°，下扇从 180° 到 360°
        let topStartAngle: Double = 0
        let topEndAngle: Double = 180
        
        let bottomStartAngle: Double = 180
        let bottomEndAngle: Double = 360
        
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isShuffling = false
                    revealedCards = Array(deck.shuffled().prefix(3))
                    shouldShowReading = true
                }
            }
        }
    }
}

// MARK: - Array 安全下标
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}