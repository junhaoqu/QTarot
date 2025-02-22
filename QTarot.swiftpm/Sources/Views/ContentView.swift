import SwiftUI

struct ContentView: View {
    @State private var showingQuestionInput = false
    @State private var question = ""
    @State private var selectedMode: ReadingMode = .randomReading
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("card_back")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.6))
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink {
                            DictView()
                        } label: {
                            Image("book")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .padding()
                                .shadow(color: .gold.opacity(0.5), radius: 10)
                        }
                    }
                    
                    Spacer()
                    
                    Text("QTarot")
                        .font(.custom("Papyrus", size: 100))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .gold.opacity(0.4), radius: 10, x: 0, y: 0)
                    
                    Spacer()
                    
                    HStack(spacing: 100) {
                        // Start with a Card 按钮
                        NavigationLink {
                            TarotCardGridView(mode: .randomReading)
                        } label: {
                            VStack(spacing: -40) {
                                Text("Pick a Card")
                                    .foregroundColor(.white)
                                    .font(.custom("Papyrus", size: 40))
                                    .frame(height: 60)
                                    .shadow(color: .gold.opacity(0.8), radius: 8, x: 0, y: 0)
                                
                                Image("sun_button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 400)
                                    .shadow(color: .gold.opacity(0.5), radius: 10)
                            }
                            .offset(x: -20)
                        }
                        
                        // Ask a Question 按钮
                        NavigationLink {
                            QuestionInputView(question: $question)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            VStack(spacing: -40) {
                                Text("Ask a Question")
                                    .foregroundColor(.white)
                                    .font(.custom("Papyrus", size: 40))
                                    .frame(height: 60)
                                    .offset(x: -20)
                                    .shadow(color: .gold.opacity(0.8), radius: 8, x: 0, y: 0)
                                
                                Image("moon_button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 400)
                                    .shadow(color: .gold.opacity(0.5), radius: 10)
                            }
                            .offset(x: 20)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        }
    }
}

struct MenuButton: View {
    let title: String
    let subtitle: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .font(.title)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(title) 
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
