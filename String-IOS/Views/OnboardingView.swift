//
//  OnboardingView.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentIndex = 0
    private var onboardingText: [String] = [
        "Find amazing people around you",
        "Find your perfect match",
        "Meet and chat to people near you"
    ]
    @Namespace private var namespace
    @State private var animate: Bool = false
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    var body: some View {
        
        ZStack {
            
            Color.darkBackground
                .ignoresSafeArea()
            
            OnboardingCircleWidgets(
                currentIndex: currentIndex
            )
            .opacity(animate ? 1:0)
            .animation(.easeInOut(duration: 0.8).delay(0.4), value: animate)
            
            VStack(spacing: 40) {
                
                OnboardingCardDeck(
                    index: $currentIndex
                )
                .padding(.top, 20)
                .scaleEffect(animate ? 1 : 0.8)
                .opacity(animate ? 1:0)
                .animation(.easeInOut(duration: 0.5), value: animate)
                
                VStack(spacing: 30) {
                    
                    Text(onboardingText[currentIndex])
                        .stingerRegularFont(size: 30)
                        .foregroundStyle(.accent)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .offset(x: 0, y: animate ? 0 : 100)
                        .opacity(animate ? 1: 0)
                        .animation(.spring, value: animate)
                    
                    OnboardingPageIndicator(
                        currentPage: currentIndex
                    )
                    .offset(x: 0, y: animate ? 0 : 100)
                    .opacity(animate ? 1: 0)
                    .animation(.spring.delay(0.2), value: animate)
                    
                    Group {
                        if currentIndex == 2 {
                            PrimaryBtn(
                                onButtonPressed: {
                                    rootViewModel.appState = .authentication
                                },
                                buttonColor: .accent,
                                buttonLabel: "Lets Start",
                                labelColor: .white,
                            )
                            .frame(maxWidth: 210)
                            .matchedGeometryEffect(id: "primaryButton", in: namespace)
                        } else {
                            HStack(spacing: 15) {
                                PrimaryBtn(
                                    onButtonPressed: {
                                        rootViewModel.appState = .authentication
                                    },
                                    buttonColor: .white,
                                    buttonLabel: "Skip",
                                    labelColor: .black,
                                )
                                
                                PrimaryBtn(
                                    onButtonPressed: {
                                        currentIndex += 1
                                    },
                                    buttonColor: .accent,
                                    buttonLabel: "Next",
                                    labelColor: .white,
                                )
                                
                            }
                            .frame(maxWidth: 260)
                            .matchedGeometryEffect(id: "primaryButton", in: namespace)
                        }
                    }
                    .animation(.easeInOut, value: currentIndex)
                    .padding(.top, 20)
                    .offset(x: 0, y: animate ? 0 : 100)
                    .opacity(animate ? 1: 0)
                    .animation(.spring.delay(0.4), value: animate)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
        
        }
        .onAppear {
            animate = true
        }
    }
    
}

#Preview {
    OnboardingView()
}
