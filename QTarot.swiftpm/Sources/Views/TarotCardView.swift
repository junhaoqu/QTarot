import SwiftUI

struct TarotCardView: View {
    let card: TarotCard
    let isCenter: Bool  // 添加这个属性来控制渲染质量
    @State private var isFloating = false
    
    var body: some View {
        VStack(spacing: 8) {
            Image("card_back")
                .resizable()
                .interpolation(isCenter ? .high : .medium)  // 控制图片渲染质量
                .scaledToFit()
                .frame(width: 260, height: 380)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gold, lineWidth: 1)
                )
                .shadow(
                    color: .black.opacity(0.3),
                    radius: isFloating ? 8 : 4,
                    x: 0,
                    y: isFloating ? 4 : 2
                )
                .offset(y: isFloating ? -3 : 0)
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.2)
                .repeatForever(autoreverses: true)
            ) {
                isFloating = true
            }
        }
    }
}

// Example preview
#Preview {
    NavigationView {
        TarotCardView(card: TarotCard(
            name: "The Fool",
            imageName: "fool",
            meaning: "New beginnings, spontaneity, and a leap of faith.",
            dailyLife: "Embrace adventure and take fresh opportunities.",
            relationship: "Be open and spontaneous in your connections.",
            job: "Consider new ventures with cautious optimism.",
            reversedMeaning: ""
        ), isCenter: true)
    }
}
