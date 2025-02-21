import SwiftUI

struct TarotCardGridView: View {
    let mode: ReadingMode
    
    // 只维护要显示的 20 张卡
    @State private var displayCards: [TarotCard]
    
    // 点击卡后
    @State private var selectedCard: TarotCard?
    @State private var showingReading = false
    
    // 无限滑动（横向）相关
    @State private var scrollOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDragging = false
    
    // 选中卡片的三段式动画
    @State private var selectedCardOffset: CGFloat = 0
    @State private var selectedCardRotation: Double = 0
    @State private var selectedCardScale: CGFloat = 1
    
    // 图片预加载
    @StateObject private var imageLoader = ImagePreloader()
    
    // 自定义初始化：只取前 20 张
    init(mode: ReadingMode) {
        self.mode = mode
        
        let fullDeck = TarotDeck.shared.cards
        let shuffledDeck = fullDeck.shuffled()
        let limitedDeck = Array(shuffledDeck.prefix(20))
        
        _displayCards = State(initialValue: limitedDeck)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth  = geometry.size.width
            let screenHeight = geometry.size.height
            
            // 卡片大小可自行调整
            let cardWidth:  CGFloat = screenWidth * 0.65
            let cardHeight: CGFloat = screenHeight * 0.55
            
            // 卡片之间的横向间距（决定卡片左右分布稀疏/紧密）
            let cardSpacing: CGFloat = cardWidth * 0.15
            
            // 总内容宽度 = N 张卡 * 间距
            let totalContentWidth = CGFloat(displayCards.count) * cardSpacing
            
            // "底部"Y 坐标：让卡片底部贴近屏幕下方
            let baseY = screenHeight * 0.8
            
            ZStack {
                // 背景图片
                Image("pick_bg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.8))  // 添加暗化效果使卡片更突出
                
                // 添加提示文字
                VStack(spacing: 15) {
                    Text("Pick One Card")
                        .font(.custom("Papyrus", size: 40))
                        .fontWeight(.heavy)  // 使用最粗的字重
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 2)  // 增强阴影
                        .overlay(  // 添加描边效果使文字更突出
                            Text("Pick One Card")
                                .font(.custom("Papyrus", size: 32))
                                .fontWeight(.heavy)
                                .foregroundColor(.black.opacity(0.3))
                                .offset(x: 1, y: 1)
                        )
                    
                    Text("Move Left or Right to Shuffle")
                        .font(.custom("Papyrus", size: 20))
                        .fontWeight(.semibold)  // 副标题也稍微加粗
                        .foregroundColor(Color.customGold)
                        .opacity(0.8)
                        .shadow(color: .black.opacity(0.5), radius: 2)
                    
                    Spacer()
                }
                
                // 横向无限循环：stride(-1..2)
                ForEach(Array(stride(from: -1, to: 2, by: 1)), id: \.self) { cycle in
                    ForEach(displayCards) { card in
                        let index = indexOf(card)
                        
                        // 基础 X 偏移
                        let cardOffset = CGFloat(index) * cardSpacing
                        // cycleOffset 用于复制多份
                        let cycleOffset = CGFloat(cycle) * totalContentWidth
                        
                        // 实际 X 坐标：中心点 + (基础偏移 + 拖动 + cycleOffset)
                        // 让 baseX = 屏幕中点，卡片默认居中，左右滑动
                        let baseX = screenWidth * 0.5
                        let adjustedX = baseX + (cardOffset + scrollOffset + dragOffset + cycleOffset)
                        
                        // 相对中心的距离
                        let distanceFromCenter = adjustedX - baseX
                        
                        // 扇形角度：距离越大，旋转越大
                        // 你可自行微调 angleFactor, maxAngle
                        let angle = angleForCard(distance: distanceFromCenter,
                                                 angleFactor: 0.15,
                                                 maxAngle: 40)
                        
                        TarotCardView(card: card, isCenter: false)
                            .frame(width: cardWidth, height: cardHeight)
                            // 先将卡片放在 (adjustedX, baseY) 底部对齐
                            .position(x: adjustedX, y: baseY)
                            
                            // 以"底边"为锚点旋转 angle 度，实现左右扇形
                            .rotationEffect(.degrees(angle), anchor: .bottom)
                            
                            // 若是选中的卡，则上浮 / 翻转 / 放大
                            .offset(y: selectedCard?.id == card.id ? selectedCardOffset : 0)
                            .rotation3DEffect(
                                .degrees(selectedCard?.id == card.id ? selectedCardRotation : 0),
                                axis: (x: 0, y: 1, z: 0),
                                perspective: 0.7
                            )
                            .scaleEffect(selectedCard?.id == card.id ? selectedCardScale : 1)
                            
                            .shadow(color: .black.opacity(0.3),
                                    radius: screenWidth * 0.02,
                                    x: 0, y: screenHeight * 0.01)
                            
                            // 点击 -> 播放三段式动画
                            .onTapGesture {
                                selectedCard = card
                                animateCardSelection(screenHeight: screenHeight, baseY: baseY)
                            }
                    }
                }
            }
            // 拖拽手势：横向无限滑动
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        // 横向拖动
                        state = value.translation.width
                        isDragging = true
                    }
                    .onEnded { value in
                        isDragging = false
                        // 简单带惯性的滚动
                        let velocity = value.predictedEndTranslation.width - value.translation.width
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            var targetOffset = scrollOffset + value.translation.width + velocity * 0.2
                            
                            // 无限循环处理
                            if abs(targetOffset) > totalContentWidth {
                                targetOffset = targetOffset.truncatingRemainder(dividingBy: totalContentWidth)
                            }
                            scrollOffset = targetOffset
                        }
                    }
            )
            // 点击卡片后，弹出阅读视图
            .sheet(isPresented: $showingReading) {
                if let card = selectedCard {
                    NavigationView {
                        VStack(spacing: 0) {
                            // 自定义下拉指示器
                            RoundedRectangle(cornerRadius: 2.5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 36, height: 5)
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                            
                            ReadingView(card: card, mode: mode)
                                .navigationBarItems(trailing: Button("Close") {
                                    showingReading = false
                                })
                        }
                    }
                    .presentationDetents([.large])
                }
            }
            .onAppear {
                // 初始时预加载 20 张卡的图片
                imageLoader.preloadImages(for: displayCards)
            }
            .navigationTitle("Select a Card")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - 点击卡片后动画：上浮 -> Y轴翻转 -> 显示阅读
    private func animateCardSelection(screenHeight: CGFloat, baseY: CGFloat) {
        // 让卡片浮到屏幕上方 1/3 处，而不是中间
        let targetY = screenHeight * 0.4  // 修改这里
        let floatDistance = baseY - targetY
        
        // 1) 上浮 + 放大
        withAnimation(.easeOut(duration: 0.5)) {
            selectedCardOffset = -floatDistance
            selectedCardScale = 1.2  // 稍微放大一点
        }
        
        // 2) Y 轴翻转 360°
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            selectedCardRotation = 360
            selectedCardScale = 1.3  // 翻转时再放大一点
        }
        
        // 3) 1 秒后弹出阅读
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showingReading = true
            
            // 重置
            selectedCardOffset = 0
            selectedCardRotation = 0
            selectedCardScale = 1
        }
    }
    
    // MARK: - 查找卡片的 index
    private func indexOf(_ card: TarotCard) -> Int {
        displayCards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    // MARK: - 扇形角度函数
    /// 根据卡片相对中心的距离，映射到一个旋转角度
    private func angleForCard(distance: CGFloat, angleFactor: Double, maxAngle: Double) -> Double {
        // distance > 0 表示卡在右边，< 0 表示卡在左边
        let rawAngle = Double(distance) * angleFactor
        // 限制在 [-maxAngle, maxAngle] 之间
        return max(min(rawAngle, maxAngle), -maxAngle)
    }
}

// MARK: - 图片预加载器
class ImagePreloader: ObservableObject {
    private var loadedImages: Set<String> = []
    private var imageCache = NSCache<NSString, UIImage>()
    
    func preloadImages(for cards: [TarotCard]) {
        for card in cards {
            if !loadedImages.contains(card.imageName) {
                loadedImages.insert(card.imageName)
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    guard let self = self else { return }
                    if let url = URL(string: card.imageName),
                       let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: card.imageName as NSString)
                    }
                }
            }
        }
    }
    
    func getImage(for imageName: String) -> UIImage? {
        imageCache.object(forKey: imageName as NSString)
    }
}

// MARK: - 预览
#Preview {
    NavigationView {
        TarotCardGridView(mode: .randomReading)
    }
}
