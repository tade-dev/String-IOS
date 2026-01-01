import SwiftUI

struct CardItem: Identifiable {
    let id = UUID()
    let color: Color
    let image: String
}

struct OnboardingCardDeck: View {
    
    let cards: [CardItem] = [
        .init(color: .gray, image: "man1"),
        .init(color: .blue, image: "woman1"),
        .init(color: .green, image: "man2"),
        .init(color: .orange, image: "woman2")
    ]
    
    @Binding var index: Int
    @State private var drag: CGFloat = 0
    
    private let cardWidth: CGFloat = 300
    private let cardHeight: CGFloat = 460
    private let swipeThreshold: CGFloat = 90
    
    var body: some View {
        GeometryReader { geo in
            ZStack {

                ForEach(cards.indices, id: \.self) { cardIndex in
                    cardView(for: cardIndex, geo: geo)
                }
            }
            .frame(maxWidth: .infinity)
            .gesture(dragGesture)
        }
    }
    
    private func cardView(for cardIndex: Int, geo: GeometryProxy) -> some View {
 
        let isActive = cardIndex == index
        let offsetFromCenter = CGFloat(cardIndex - index)
        
        let dragProgress = isActive ? (drag / geo.size.width) : 0
        
        let totalOffset = offsetFromCenter + dragProgress
        
        let scale: CGFloat = isActive ? 1.0 : max(0.80, 0.88 - abs(totalOffset) * 0.05)
        
        let rotation: Double = -10.0 + (Double(totalOffset) * 20)
        
        let baseXOffset = totalOffset * 200
        let xOffset = baseXOffset
        

        let yOffset = isActive
            ? pow(abs(totalOffset), 1.2) * 60
            : pow(abs(offsetFromCenter), 1.2) * 60
        
        let zIndex = Double(cards.count - cardIndex)
        
        return OnboardingCardView(item: cards[cardIndex])
            .frame(width: cardWidth, height: cardHeight)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .rotation3DEffect(
                .degrees(rotation * 0.3),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .rotation3DEffect(
                .degrees(abs(Double(totalOffset)) * -6),
                axis: (x: 1, y: 0, z: 0)
            )
            .offset(x: xOffset, y: yOffset)
            .zIndex(zIndex)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                drag = value.translation.width
            }
            .onEnded { value in
                let velocity = value.predictedEndTranslation.width
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    let maxSwipeIndex = 2

                    if (drag < -swipeThreshold || velocity < -300) && index < maxSwipeIndex {
                        index += 1
                    }

                    else if (drag > swipeThreshold || velocity > 300) && index > 0 {
                        index -= 1
                    }
                    drag = 0
                }
            }
    }
    
    
}

struct OnboardingCardView: View {
    let item: CardItem
    
    var body: some View {
        
        Image(item.image)
            .resizable()
            .scaledToFill()
            .frame(width: 270, height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

#Preview {
    OnboardingCardDeck(
        index: .constant(0)
    )
}
