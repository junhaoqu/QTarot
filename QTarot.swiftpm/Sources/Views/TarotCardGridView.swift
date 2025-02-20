import SwiftUI

struct TarotCardGridView: View {
    let mode: ReadingMode
    @State private var selectedCard: TarotCard?
    @State private var showingReading = false
    @State private var scrollOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var selectedCardOffset: CGFloat = 0
    @State private var selectedCardRotation: Double = 0
    @State private var selectedCardScale: CGFloat = 1
    
    // 添加预加载管理器
    @StateObject private var imageLoader = ImagePreloader()
    
    // 添加可见卡片范围追踪
    @State private var visibleCardIndices: Set<Int> = []
    
    // 添加中心卡片动画状态
    @State private var centerCardScale: CGFloat = 1.0
    @State private var centerCardGlow: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let screenWidth = geometry.size.width
            let safeAreaInsets = geometry.safeAreaInsets
            
            let availableHeight = screenHeight - safeAreaInsets.top - safeAreaInsets.bottom
            let cardHeight = availableHeight * 0.95
            let cardWidth = screenWidth * 0.9
            let cardSpacing = cardHeight * 0.15
            let totalContentHeight = CGFloat(TarotDeck.shared.cards.count) * cardSpacing
            
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                // 修复 ForEach 范围
                ForEach(Array(stride(from: -1, to: 2, by: 1)), id: \.self) { cycle in
                    ForEach(TarotDeck.shared.cards) { card in
                        let index = indexOf(card)
                        let cardOffset = CGFloat(index) * cardSpacing
                        let cycleOffset = CGFloat(cycle) * totalContentHeight
                        let adjustedOffset = cardOffset + scrollOffset + dragOffset + cycleOffset
                        let distance = abs(adjustedOffset)
                        let isCenter = distance < cardSpacing / 2
                        
                        TarotCardView(card: card, isCenter: isCenter)
                            .frame(width: cardWidth, height: cardHeight)
                            .scaleEffect(scale(for: distance, in: screenHeight))
                            .offset(y: adjustedOffset)
                            .opacity(isCenter ? 1 : 0.3)
                            .zIndex(1000 - distance)
                            .rotation3DEffect(
                                .degrees(rotation(for: distance, in: screenHeight)),
                                axis: (x: 1, y: 0, z: 0)
                            )
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
                                if distance < cardHeight / 4 {
                                    selectedCard = card
                                    animateCardSelection(screenHeight: screenHeight)
                                }
                            }
                            .onChange(of: isCenter) { newValue in
                                if newValue {
                                    // 预加载当前卡片及其相邻卡片的图片
                                    imageLoader.preloadImages(for: getAdjacentCards(index: index))
                                    
                                    // 添加成为中心卡片时的动画
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        centerCardScale = 1.05
                                        centerCardGlow = 0.7
                                    }
                                } else if centerCardScale > 1.0 {
                                    // 离开中心时的动画
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
                            
                            // 处理循环
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
            // 预加载初始可见卡片
            let initialCards = getInitialVisibleCards()
            imageLoader.preloadImages(for: initialCards)
        }
    }
    
    private func animateCardSelection(screenHeight: CGFloat) {
        // 1. 卡片向上浮动
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
    
    // 辅助函数
    private func indexOf(_ card: TarotCard) -> Int {
        TarotDeck.shared.cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
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
    
    // 获取相邻卡片
    private func getAdjacentCards(index: Int) -> [TarotCard] {
        let cards = TarotDeck.shared.cards
        let prevIndex = (index - 1 + cards.count) % cards.count
        let nextIndex = (index + 1) % cards.count
        return [
            cards[prevIndex],
            cards[index],
            cards[nextIndex]
        ]
    }
    
    // 获取初始可见卡片
    private func getInitialVisibleCards() -> [TarotCard] {
        let cards = TarotDeck.shared.cards
        let centerIndex = cards.count / 2
        return Array(cards[max(0, centerIndex-2)...min(cards.count-1, centerIndex+2)])
    }
}

#Preview {
    NavigationView {
        TarotCardGridView(mode: .randomReading)
    }
}

// 添加自定义转场动画
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

// 图片预加载管理器
class ImagePreloader: ObservableObject {
    private var loadedImages: Set<String> = []
    private var imageCache = NSCache<NSString, UIImage>()
    
    func preloadImages(for cards: [TarotCard]) {
        for card in cards {
            if !loadedImages.contains(card.imageName) {
                loadedImages.insert(card.imageName)
                
                // 异步加载图片
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