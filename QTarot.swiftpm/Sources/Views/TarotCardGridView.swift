import SwiftUI

struct TarotCardGridView: View {
    let mode: ReadingMode
    @State private var selectedCard: TarotCard?
    @State private var showingReading = false
    @State private var scrollOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let screenWidth = geometry.size.width
            let safeAreaInsets = geometry.safeAreaInsets
            
            // 调整卡片尺寸以填充红框区域
            let availableHeight = screenHeight - safeAreaInsets.top - safeAreaInsets.bottom
            let cardHeight = availableHeight * 0.95 // 几乎填满可用高度
            let cardWidth = screenWidth * 0.9 // 几乎填满屏幕宽度
            let cardSpacing = cardHeight * 0.15 // 调整间距使堆叠效果更明显
            let totalContentHeight = CGFloat(TarotDeck.shared.cards.count) * cardSpacing
            
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ForEach(TarotDeck.shared.cards) { card in
                    let index = indexOf(card)
                    let cardOffset = CGFloat(index) * cardSpacing
                    let adjustedOffset = cardOffset + scrollOffset + dragOffset
                    let wrappedOffset = wrap(adjustedOffset, in: totalContentHeight)
                    let distance = abs(wrappedOffset)
                    
                    TarotCardView(card: card)
                        .frame(width: cardWidth, height: cardHeight)
                        .scaleEffect(scale(for: distance, in: screenHeight))
                        .offset(y: wrappedOffset)
                        .opacity(opacity(for: distance, in: screenHeight))
                        .zIndex(1000 - distance)
                        .rotation3DEffect(
                            .degrees(rotation(for: distance, in: screenHeight)),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: screenWidth * 0.02,
                            x: 0,
                            y: screenHeight * 0.01
                        )
                        .onTapGesture {
                            if distance < cardHeight / 4 {
                                selectedCard = card
                                showingReading = true
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
                            let targetOffset = scrollOffset + value.translation.height + velocity * 0.2
                            let cardIndex = round(targetOffset / cardSpacing)
                            scrollOffset = cardIndex * cardSpacing
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
                            showingReading = false
                        })
                }
            }
        }
    }
    
    // 辅助函数
    private func indexOf(_ card: TarotCard) -> Int {
        TarotDeck.shared.cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    private func wrap(_ offset: CGFloat, in total: CGFloat) -> CGFloat {
        let wrapped = offset.truncatingRemainder(dividingBy: total)
        return wrapped > total / 2 ? wrapped - total : wrapped
    }
    
    private func scale(for distance: CGFloat, in height: CGFloat) -> CGFloat {
        let maxScale: CGFloat = 1.0
        let minScale: CGFloat = 0.5
        let scale = maxScale - (distance / height) * 0.8 // 减小缩放变化率
        return min(max(scale, minScale), maxScale)
    }
    
    private func opacity(for distance: CGFloat, in height: CGFloat) -> Double {
        let opacity = 1 - (distance / height) * 1.5
        return min(max(opacity, 0.3), 1)
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