import SwiftUI

struct ThreeCardReadingView: View {
    @Environment(\.dismiss) private var dismiss
    let cards: [TarotCard]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 添加背景
                Image("table")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.8))
                
                ScrollView {
                    VStack(spacing: 30) {
                        Text("Your Reading")
                            .font(.custom("Papyrus", size: 40))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
                        // 时间轴标题
                        HStack(spacing: 30) {
                            ForEach(["Past", "Present", "Future"], id: \.self) { title in
                                Text(title)
                                    .font(.custom("Papyrus", size: 24))
                                    .foregroundColor(.customGold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // 卡片展示
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(Array(zip(cards.indices, cards)), id: \.0) { index, card in
                                VStack(spacing: 15) {
                                    Image("card_back")
                                        .resizable()
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .frame(maxWidth: geometry.size.width * 0.25)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.5), radius: 10)
                                    
                                    Text(card.name)
                                        .font(.custom("Papyrus", size: 22))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    
                                    Text(card.meaning)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white.opacity(0.9))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 10)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 40)
                    }
                }
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
    }
} 