//
//  CardData.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//


import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    let color: Color
    let title: String
}

struct SwipeableCards: View {
    @State private var cards: [CardData] = [
        CardData(color: .purple, title: "Card 1"),
        CardData(color: .blue, title: "Card 2"),
        CardData(color: .green, title: "Card 3"),
        CardData(color: .orange, title: "Card 4"),
        CardData(color: .pink, title: "Card 5")
    ]
    
    var body: some View {
            
        ZStack(alignment: .topLeading) {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                if index < 2 {
                    CardView(card: card, onRemove: {
                        withAnimation {
                            cards.removeAll { $0.id == card.id }
                        }
                    })
                    .offset(x: CGFloat(index) * 20, y: CGFloat(index) * 20)
                    .zIndex(Double(cards.count - index))
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct CardView: View {
    let card: CardData
    let onRemove: () -> Void
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image(.woman1)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                VStack {
                    Spacer()
                    Text(card.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 1.5)
                    .fill(.white)
            })
            .offset(x: offset.width, y: offset.height)
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        isDragging = true
                    }
                    .onEnded { gesture in
                        withAnimation(.spring()) {
                            let swipeThreshold: CGFloat = 100
                            if abs(offset.width) > swipeThreshold {
                                offset = CGSize(
                                    width: offset.width > 0 ? 500 : -500,
                                    height: offset.height
                                )
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    onRemove()
                                }
                            } else {
                                offset = .zero
                            }
                        }
                        isDragging = false
                    }
            )
        }
        .aspectRatio(0.7, contentMode: .fit)
    }
    
    func getOpacity() -> Double {
        let swipeThreshold: CGFloat = 100
        let progress = min(abs(offset.width) / swipeThreshold, 1.0)
        return 1.0 - Double(progress * 0.5)
    }
}

#Preview {
    SwipeableCards()
}
