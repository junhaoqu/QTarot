import SwiftUI

struct TarotCardGridView: View {
    let mode: ReadingMode
    
    // 改动 1：只在这里维护我们要“显示”的 20 张卡
    @State private var displayCards: [TarotCard]
    
    @State private var selectedCard: TarotCard?
    @State private var showingReading = false
    
    @State private var scrollOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var selectedCardOffset: CGFloat = 0
    @State private var selectedCardRotation: Double = 0
    @State private var selectedCardScale: CGFloat = 1
    
    @StateObject private var imageLoader = ImagePreloader()
    
    // 中心卡片的动画状态
    @State private var centerCardScale: CGFloat = 1.0
    @State private var centerCardGlow: CGFloat = 0.0
    
    // 自定义初始化：只取 20 张卡放进 displayCards
    init(mode: ReadingMode) {
        self.mode = mode
        
        // 整副卡
        let fullDeck = TarotDeck.shared.cards
        // 洗牌
        let shuffledDeck = fullDeck.shuffled()
        // 只取前 20 张
        let limitedDeck = Array(shuffledDeck.prefix(20))
        
        // 用这 20 张来展示
        _displayCards = State(initialValue: limitedDeck)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let screenWidth = geometry.size.width
            let safeAreaInsets = geometry.safeAreaInsets
            
            let availableHeight = screenHeight - safeAreaInsets.top - safeAreaInsets.bottom
            let cardHeight = availableHeight * 0.95
            let cardWidth = screenWidth * 0.9
            
            // 卡片之间的垂直间距
            let cardSpacing = cardHeight * 0.15
            // 总高度（因为我们只显示 displayCards.count 张卡）
            let totalContentHeight = CGFloat(displayCards.count) * cardSpacing
            
            ZStack {
                Color.black.ignoresSafeArea()
                
                // 做循环滚动的效果，可以像你原先那样再 ForEach stride(from: -1, to: 2, by: 1)
                // 也可以根据你自己的需求
                ForEach(Array(stride(from: -1, to: 2, by: 1)), id: \.self) { cycle in
                    ForEach(displayCards) { card in
                        let index = indexOf(card)
                        let cardOffset = CGFloat(index) * cardSpacing
                        let cycleOffset = CGFloat(cycle) * totalContentHeight
                        
                        let adjustedOffset = cardOffset + scrollOffset + dragOffset + cycleOffset
                        let distance = abs(adjustedOffset)
                        
                        // 判断是否是距离中心最近的卡
                        let isCenter = distance < cardSpacing / 2
                        
                        TarotCardView(card: card, isCenter: isCenter)
                            .frame(width: cardWidth, height: cardHeight)
                            // 缩放
                            .scaleEffect(scale(for: distance, in: screenHeight))
                            // 垂直偏移
                            .offset(y: adjustedOffset)
                            // 离中心越远越透明
                            .opacity(isCenter ? 1 : 0.3)
                            // zIndex 提前渲染离中心近的卡
                            .zIndex(1000 - distance)
                            // 3D 旋转
                            .rotation3DEffect(
                                .degrees(rotation(for: distance, in: screenHeight)),
                                axis: (x: 1, y: 0, z: 0)
                            )
                            // 若是选中的卡，则加上放大和翻转动画
                            .scaleEffect(selectedCard?.id == card.id ? selectedCardScale : 1)
                            .offset(y: selectedCard?.id == card.id ? selectedCardOffset : 0)
                            .rotation3DEffect(
                                .degrees(selectedCard?.id == card.id ? selectedCardRotation : 0),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .shadow(
                                color: .black.opacity(0.3),
                                radius: screenWidth * 0.02,
                                x: 0,
                                y: screenHeight * 0.01
                            )
                            .onTapGesture {
                                // 只有足够靠近中心时才可点
                                if distance < cardHeight / 4 {
                                    // 这里可以改成选中“当前这张”或者再从整副牌随机一张
                                    // 示例：我们这里点击后，会再用整副牌随机一张  ->  selectedCard = TarotDeck.shared.cards.randomElement()
                                    // 如果你想看刚才点击的这张，就把这行换成 selectedCard = card
                                    selectedCard = TarotDeck.shared.cards.randomElement()
                                    animateCardSelection(screenHeight: screenHeight)
                                }
                            }
                            .onChange(of: isCenter) { newValue in
                                // 切换到中心时加载相邻图片
                                if newValue {
                                    imageLoader.preloadImages(for: getAdjacentCards(index: index))
                                    // 放大、发光
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        centerCardScale = 1.05
                                        centerCardGlow = 0.7
                                    }
                                } else if centerCardScale > 1.0 {
                                    // 离开中心时恢复
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        centerCardScale = 1.0
                                        centerCardGlow = 0
                                    }
                                }
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                        isDragging = true
                    }
                    .onEnded { value in
                        isDragging = false
                        let velocity = value.predictedEndTranslation.height - value.translation.height
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            var targetOffset = scrollOffset + value.translation.height + velocity * 0.2
                            
                            // 处理循环滚动
                            if abs(targetOffset) > totalContentHeight {
                                targetOffset = targetOffset.truncatingRemainder(dividingBy: totalContentHeight)
                            }
                            scrollOffset = targetOffset
                        }
                    }
            )
        }
        .navigationTitle("Select a Card")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingReading) {
            if let card = selectedCard {
                NavigationView {
                    ReadingView(card: card, mode: mode)
                        .navigationBarItems(trailing: Button("Close") {
                            withAnimation(.easeOut(duration: 0.2)) {
                                showingReading = false
                            }
                        })
                }
                .presentationDetents([.large])
            }
        }
        .onAppear {
            // 初始可见卡片预加载
            let initialCards = getInitialVisibleCards()
            imageLoader.preloadImages(for: initialCards)
        }
    }
    
    // 点击卡片后动画流程
    private func animateCardSelection(screenHeight: CGFloat) {
        // 1. 向上浮动
        withAnimation(.easeOut(duration: 0.3)) {
            selectedCardOffset = -screenHeight * 0.1
            selectedCardScale = 1.1
        }
        
        // 2. 卡片翻转
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            selectedCardRotation = 360
        }
        
        // 3. 显示阅读视图
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showingReading = true
            
            // 重置动画状态
            selectedCardOffset = 0
            selectedCardRotation = 0
            selectedCardScale = 1
        }
    }
    
    // MARK: - Index / 邻居卡
    private func indexOf(_ card: TarotCard) -> Int {
        // 从我们只显示的 displayCards 里找 index
        return displayCards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    private func getAdjacentCards(index: Int) -> [TarotCard] {
        // 同样只从 displayCards 里取相邻
        let prevIndex = (index - 1 + displayCards.count) % displayCards.count
        let nextIndex = (index + 1) % displayCards.count
        return [displayCards[prevIndex], displayCards[index], displayCards[nextIndex]]
    }
    
    private func getInitialVisibleCards() -> [TarotCard] {
        // 简单地取中间附近的几张，也可以自行决定
        let centerIndex = displayCards.count / 2
        let lowerBound = max(0, centerIndex - 2)
        let upperBound = min(displayCards.count - 1, centerIndex + 2)
        return Array(displayCards[lowerBound...upperBound])
    }
    
    // MARK: - 视觉相关辅助
    private func scale(for distance: CGFloat, in height: CGFloat) -> CGFloat {
        let maxScale: CGFloat = 1.0
        let minScale: CGFloat = 0.5
        let scale = maxScale - (distance / height) * 0.8
        return min(max(scale, minScale), maxScale)
    }
    
    private func rotation(for distance: CGFloat, in height: CGFloat) -> Double {
        let maxRotation: Double = 60
        let rotation = (distance / height) * maxRotation
        return min(max(rotation, -maxRotation), maxRotation)
    }
}

// 示例：自定义转场动画
extension AnyTransition {
    static var cardReveal: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.9)
                .combined(with: .opacity)
                .animation(.spring(response: 0.3, dampingFraction: 0.8)),
            removal: .scale(scale: 0.9)
                .combined(with: .opacity)
                .animation(.easeOut(duration: 0.2))
        )
    }
}

// 简单的图片预加载管理器
class ImagePreloader: ObservableObject {
    private var loadedImages: Set<String> = []
    private var imageCache = NSCache<NSString, UIImage>()
    
    func preloadImages(for cards: [TarotCard]) {
        for card in cards {
            if !loadedImages.contains(card.imageName) {
                loadedImages.insert(card.imageName)
                
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    if let url = URL(string: card.imageName),
                       let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        self?.imageCache.setObject(image, forKey: card.imageName as NSString)
                    }
                }
            }
        }
    }
    
    func getImage(for imageName: String) -> UIImage? {
        return imageCache.object(forKey: imageName as NSString)
    }
}

// 预览
#Preview {
    NavigationView {
        TarotCardGridView(mode: .randomReading)
    }
}
