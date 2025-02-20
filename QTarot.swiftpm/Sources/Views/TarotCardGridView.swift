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
                        
                        TarotCardView(card: card)
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