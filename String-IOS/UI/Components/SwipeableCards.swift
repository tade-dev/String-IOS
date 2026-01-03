//
//  CardData.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//


import SwiftUI

struct CardData: Identifiable, Equatable, Hashable {
    let id = UUID()
    let color: Color
    let title: String
    let image: ImageResource
}

struct SwipeableCards: View {
    
    let namespace: Namespace.ID
    
    @State private var cards: [CardData] = [
        CardData(color: .purple, title: "Card 1", image: .man1),
        CardData(color: .blue, title: "Card 2", image: .man2),
        CardData(color: .green, title: "Card 3", image: .woman1),
        CardData(color: .orange, title: "Card 4", image: .woman2),
    ]
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                if index < 2 {
                    CardView(card: card, onRemove: {
                        withAnimation {
                            cards.removeAll { $0.id == card.id }
                        }
                    })
                    .matchedGeometryEffect(id: card.id, in: namespace)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                            homeViewModel.selectedUser = card
                        }
                    }
                    .offset(x: CGFloat(index) * 20, y: CGFloat(index) * 20)
                    .zIndex(Double(cards.count - index))
                    .opacity(homeViewModel.selectedUser != nil ? 0 : 1)
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
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(card.image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 5) {
                            Text("Zelia Booth,")
                                .stingerRegularFont(size: 25)
                                .foregroundStyle(.white)
                            
                            Text("19")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            
                            Image(.verifyIcon)
                        }
                        HStack(spacing: 5) {
                            Text("Singer, Friendly |")
                                .stingerRegularFont(size: 15)
                                .foregroundStyle(.white)
                            Text("Km away |")
                                .stingerRegularFont(size: 15)
                                .foregroundStyle(.white)
                            Text("Canada")
                                .stingerRegularFont(size: 15)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 25)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 1.5)
                    .fill(.white)
            }
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
}

//#Preview {
//    SwipeableCards()
//}
