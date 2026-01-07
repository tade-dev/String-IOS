//
//  MatchedView.swift
//  String-IOS
//
//  Created by BSTAR on 06/01/2026.
//

import SwiftUI

struct MatchedView: View {

    @State private var animate = false
    @State private var showArrows = false
    @State private var showCircles = false
    @State private var pulseHeart = false
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            BlurredCircleBg()
            
            AuthIntroViewCircles()

            VStack(spacing: 5) {
                Text("It’s a match!")
                    .stingerRegularFont(size: 40)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.4), value: animate)

                Text("You have liked eachother")
                    .stingerRegularFont(size: 21)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.45), value: animate)

                matchedView

                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.1)

            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    PrimaryBtn(onButtonPressed: {}, buttonLabel: "Send message!")
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.bouncy.delay(0.85), value: animate)

                    PrimaryBtn(
                        onButtonPressed: {
                            withAnimation(.easeInOut) {
                                homeViewModel.showMatchedScreen = false
                            }
                        },
                        buttonColor: .black,
                        buttonLabel: "Keep swiping!",
                        labelColor: .white
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(0.95), value: animate)
                }
                .padding(.horizontal, 20)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .onAppear {
            animate = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                showArrows = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                showCircles = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.05) {
                pulseHeart = true
            }
        }
        .navigationBarBackButtonHidden()
    }

    var matchedView: some View {
        VStack(spacing: 0) {

            HStack {
                Spacer()
                Image(.rightCurvedArrow)
                    .offset(
                        x: showArrows ? 0 : 20,
                        y: showArrows ? 0 : -20
                    )
                    .opacity(showArrows ? 1 : 0)
                    .animation(
                        .easeOut(duration: 0.4),
                        value: showArrows
                    )
            }

            GeometryReader { proxy in
                ZStack {

                    Image(.man1)
                        .resizable()
                        .frame(width: 165, height: 165)
                        .clipShape(.circle)
                        .offset(
                            x: showCircles ? -proxy.size.width * 0.15 : -proxy.size.width * 0.35,
                            y: showCircles ? -proxy.size.height * 0.15 : -proxy.size.height * 0.35
                        )
                        .scaleEffect(showCircles ? 1 : 0.6)
                        .rotationEffect(.degrees(showCircles ? 0 : -14))
                        .opacity(showCircles ? 1 : 0)
                        .animation(
                            .spring(response: 0.65, dampingFraction: 0.75),
                            value: showCircles
                        )
                    
                    Image(.woman1)
                        .resizable()
                        .frame(width: 165, height: 165)
                        .clipShape(.circle)
                        .offset(
                            x: showCircles ? proxy.size.width * 0.15 : proxy.size.width * 0.35,
                            y: showCircles ? proxy.size.height * 0.15 : proxy.size.height * 0.35
                        )
                        .scaleEffect(showCircles ? 1 : 0.6)
                        .rotationEffect(.degrees(showCircles ? 0 : 14))
                        .opacity(showCircles ? 1 : 0)
                        .animation(
                            .spring(response: 0.7, dampingFraction: 0.78).delay(0.05),
                            value: showCircles
                        )
                    
                    Image(.like)
                        .resizable()
                        .frame(width: 50, height: 43)
                        .offset(
                            x: proxy.size.width * -0.15,
                            y: proxy.size.height * 0.15
                        )
                        .scaleEffect(pulseHeart ? 1.15 : 0.4)
                        .opacity(pulseHeart ? 1 : 0)
                        .animation(
                            .spring(response: 0.4, dampingFraction: 0.6),
                            value: pulseHeart
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, maxHeight: 250)

            HStack {
                Image(.curvedArrowUp)
                    .offset(
                        x: showArrows ? 0 : -20,
                        y: showArrows ? 0 : 20
                    )
                    .opacity(showArrows ? 1 : 0)
                    .animation(
                        .easeOut(duration: 0.4).delay(0.1),
                        value: showArrows
                    )
                Spacer()
            }
        }
        .padding(.top, 30)
    }
}

#Preview {
    MatchedView()
        .environmentObject(HomeViewModel())
}
