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

enum SwipeDirection {
    case left, right
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
                    CardView(
                        card: card,
                        onRemove: {
                            // Delay removal to allow animation to complete
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    cards.removeAll { $0.id == card.id }
                                }
                            }
                        },
                        shouldTriggerSwipe: index == 0
                    )
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

// MARK: - CardView
struct CardView: View {
    let card: CardData
    let onRemove: () -> Void
    let shouldTriggerSwipe: Bool
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @State private var isRemoving = false
    @State private var programmaticSwipeDirection: SwipeDirection?
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(card.image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                // Swipe Indicator Overlays
                if offset.width > 50 || programmaticSwipeDirection == .right {
                    // LIKE indicator (right swipe)
                    VStack {
                        HStack {
                            Text("LIKE")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(.green)
                                .padding(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 5)
                                )
                                .rotationEffect(.degrees(-25))
                            Spacer()
                        }
                        .padding(.leading, 40)
                        .padding(.top, 60)
                        Spacer()
                    }
                    .opacity(programmaticSwipeDirection == .right ? 1 : Double(offset.width / 100))
                } else if offset.width < -50 || programmaticSwipeDirection == .left {
                    // NOPE indicator (left swipe)
                    VStack {
                        HStack {
                            Spacer()
                            Text("NOPE")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(.red)
                                .padding(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.red, lineWidth: 5)
                                )
                                .rotationEffect(.degrees(25))
                        }
                        .padding(.trailing, 40)
                        .padding(.top, 60)
                        Spacer()
                    }
                    .opacity(programmaticSwipeDirection == .left ? 1 : Double(abs(offset.width) / 100))
                }
                
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
            .opacity(isRemoving ? 0 : 1)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if !isRemoving {
                            offset = gesture.translation
                            isDragging = true
                        }
                    }
                    .onEnded { gesture in
                        if !isRemoving {
                            handleSwipeEnd()
                        }
                    }
            )
            .onChange(of: homeViewModel.triggerSwipe) { oldValue, newValue in
                if shouldTriggerSwipe, let direction = newValue, !isRemoving {
                    performProgrammaticSwipe(direction: direction)
                }
            }
        }
        .aspectRatio(0.7, contentMode: .fit)
    }
    
    private func handleSwipeEnd() {
        let swipeThreshold: CGFloat = 100
        
        if abs(offset.width) > swipeThreshold {
            // Mark as removing immediately
            isRemoving = true
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                offset = CGSize(
                    width: offset.width > 0 ? 1000 : -1000,
                    height: offset.height
                )
            }
            
            // Call onRemove after animation
            onRemove()
        } else {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                offset = .zero
            }
        }
        isDragging = false
    }
    
    private func performProgrammaticSwipe(direction: SwipeDirection) {
        // Set the direction to show the indicator
        programmaticSwipeDirection = direction
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
            switch direction {
            case .left:
                offset = CGSize(width: -1000, height: 0)
            case .right:
                offset = CGSize(width: 1000, height: 0)
            }
        }
        
        // Mark as removing after animation starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isRemoving = true
        }
        
        // Call onRemove to trigger card removal
        onRemove()
    }
}

//#Preview {
//    SwipeableCards()
//}
