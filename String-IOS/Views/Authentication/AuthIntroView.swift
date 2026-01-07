//
//  AuthIntroView.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct AuthIntroView: View {
    
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
    
    var body: some View {
        
        ZStack {
            
            BlurredCircleBg()
            
            AuthIntroViewCircles()
            
            VStack {
                Spacer()
                heroSection
                Spacer()
                
                VStack(spacing: 20) {
                    PrimaryBtn(
                        onButtonPressed: {
                            path.append(AuthRoute.createAccountView)
                        },
                        buttonColor: .accent,   
                        buttonLabel: "Create an account",
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy, value: animate)

                    PrimaryBtn(
                        onButtonPressed: {
                            path.append(AuthRoute.signInView)
                        },
                        buttonColor: .black,
                        buttonLabel: "Sign in"
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(0.2), value: animate)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            
        }
        .onAppear {
            animate = true
        }
        .navigationBarBackButtonHidden()
        
    }
    
    var heroSection: some View {
        VStack(spacing: 0) {
            
            StringLogo(
                color: .black
            )
            .opacity(animate ? 1 : 0)
            .offset(
                x: 0,
                y: animate ? 0 : 50
            )
            .animation(.easeInOut, value: animate)
            
            HStack {
                Spacer()
                Image(.rightCurvedArrow)
            }
            .offset(
                x: animate ? 0 : UIScreen.main.bounds.width,
                y: 0,
            )
            .animation(.easeInOut.delay(0.5), value: animate)
            
            Text(attributedText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                .padding(.bottom, 25)
                .offset(
                    x: 0,
                    y: animate ? 0 : 50
                )
                .animation(.easeInOut.delay(0.1), value: animate)
            
            HStack {
                Image(.curvedArrowUp)
                Spacer()
            }
            .offset(
                x: animate ? 0 : -100,
                y: 0,
            )
            .animation(.easeInOut.delay(0.4), value: animate)
            
        }
        .offset(
            x: 0,
            y: -50
        )
    }
    
    var attributedText: AttributedString {
        var text1 = AttributedString("Meet thousand of people by creating an ")
        text1.font = .custom("StingerWideTrial-Regular", size: 25)
        
        var text2 = AttributedString("account")
        text2.font = .custom("StingerWideTrial-Bold", size: 25)
        text2.foregroundColor = .black
        
        return text1 + text2
    }
    
}

#Preview {
    NavigationStack {
        AuthIntroView(
            path:.constant(NavigationPath())
        )
    }
}
