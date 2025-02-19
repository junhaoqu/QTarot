import SwiftUI

struct ReadingView: View {
    let card: TarotCard
    let mode: ReadingMode
    @Environment(\.dismiss) private var dismiss
    @State private var isRevealed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 使用 AsyncImage 异步加载图片
                AsyncImage(url: URL(string: card.imageName)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    // 使用之前的卡背作为占位图
                    Image("card_back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 300)
                .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(card.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // 使用 transition 让内容优雅地显示
                    if isRevealed {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Meaning:")
                                .font(.headline)
                            Text(card.meaning)
                                .font(.body)
                            
                            if case .fullReading = mode {
                                Text("Reversed Meaning:")
                                    .font(.headline)
                                    .padding(.top, 8)
                                Text(card.reversedMeaning)
                                    .font(.body)
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .padding()
            }
            .padding()
        }
        .onAppear {
            // 稍微延迟显示内容，让转场动画完成
            withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
                isRevealed = true
            }
        }
    }
} 