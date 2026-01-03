//
//  UserDetailsView.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

struct UserDetailsOverlay: View {
    let user: CardData
    let namespace: Namespace.ID
    let onDismiss: () -> Void
    
    @State private var dragOffset: CGFloat = 0
    @State private var backgroundOpacity: Double = 1.0
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            // Black background
            Color.black
                .opacity(backgroundOpacity)
                .ignoresSafeArea()
            
            // Scrollable content
            ScrollView {
                LazyVStack(spacing: 0) {
                    Section {
                        VStack(alignment: .leading, spacing: 16) {
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
                                
                                Text("Product Designer at wespa")
                                    .stingerRegularFont(size: 15)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 10)
                                
                                HStack(spacing: 5) {
                                    Image(.location)
                                    Text("Km away |")
                                        .stingerRegularFont(size: 15)
                                        .foregroundStyle(.white)
                                    Text("Canada")
                                        .stingerRegularFont(size: 15)
                                        .foregroundStyle(.white)
                                    Image(.home)
                                    Text("Toronto")
                                        .stingerRegularFont(size: 15)
                                        .foregroundStyle(.white)
                                }
                                .padding(.bottom, 15)
                                
                                Text("Bio")
                                    .stingerRegularFont(size: 25)
                                    .foregroundStyle(.white)
                                
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Placerat felis neque tincidunt id imperdiet aing rhoncus eget. ")
                                    .stingerRegularFont(size: 15)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 15)
                                
                                Text("Other Photos")
                                    .stingerRegularFont(size: 25)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 10)
                                
                                LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 4)) {
                                    ForEach(0..<8) { index in
                                        Image(.woman1)
                                            .resizable()
                                            .frame(width: 78, height: 78)
                                            .clipShape(.circle)
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.top, 10)
                            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        }
                    } header: {
                        GeometryReader { geometry in
                            let offset = geometry.frame(in: .named("scroll")).minY
                            let height: CGFloat = 500
                            
                            ZStack(alignment: .top) {
                                Image(user.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width * 1.02,
                                        height: height + (offset > 0 ? offset : 0)
                                    )
                                    .clipped()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                    .cornerRadius(40)
                                    .offset(y: offset > 0 ? -offset : 0)
                                    .matchedGeometryEffect(id: user.id, in: namespace)
                                
                                VStack {
                                    HStack {
                                        AppBackButton(onTap: {
                                            onDismiss()
                                        })
                                        .foregroundStyle(.white)
                                        
                                        Spacer()
                                        
                                        Image(.ellipsis)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 60)
                                    
                                    Spacer()
                                }
                                .offset(y: offset > 0 ? -offset : 0)
                                .opacity(scrollOffset < -150 ? 0 : 1)
                                .animation(.easeInOut(duration: 0.2), value: scrollOffset < -150)
                            }
                            .preference(key: ScrollOffsetPreferenceKey.self, value: offset)
                        }
                        .frame(height: 500)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 1.02)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.scrollOffset = value
            }
            .ignoresSafeArea()
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 && scrollOffset >= 0 {
                            dragOffset = value.translation.height
                            backgroundOpacity = CGFloat(max(0.0, 1.0 - (dragOffset / 400.0)))
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 150 {
                            onDismiss()
                        } else {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                dragOffset = 0
                                backgroundOpacity = 1.0
                            }
                        }
                    }
            )
            
            StickyHeaderView(scrollOffset: scrollOffset, onDismiss: onDismiss)
        }
    }
    
    @ViewBuilder
    func StickyHeaderView(scrollOffset: CGFloat, onDismiss: @escaping () -> Void) -> some View {
        let threshold: CGFloat = -150
        let opacity = min(1, max(0, (scrollOffset - threshold) / -100))
        
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(opacity)
            
            HStack {
                AppBackButton(onTap: {
                    onDismiss()
                })
                .foregroundStyle(.white)
                .opacity(opacity)
                
                Spacer()
                
                Image(.ellipsis)
                    .opacity(opacity)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding(.top, 50)
            .padding(.bottom, 15)
        }
        .frame(height: 100)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
        .allowsHitTesting(opacity > 0.1)
    }
}

// MARK: - Scroll Offset Preference Key
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//#Preview {
//    UserDetailsOverlay()
//}
