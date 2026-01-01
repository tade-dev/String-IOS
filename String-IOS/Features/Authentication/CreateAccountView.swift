//
//  CreateAccountView.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            BlurredCircleBg()
            
            AuthIntroViewCircles()
            
            HStack {
                Image(.leftCurvedArrow)
                Spacer()
            }
            .offset(
                x: animate ? 0 : -100,
                y: UIScreen.main.bounds.height * -0.45
            )
            .animation(.easeInOut, value: animate)
            
            Text("Create an account")
                .stingerBoldFont(size: 28)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.7)
                .animation(.easeInOut.delay(0.4), value: animate)
                .offset(
                    y: UIScreen.main.bounds.height * -0.25
                )
            
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Image(.rightCurvedArrow)
                }
                .offset(
                    x: animate ? 0 : UIScreen.main.bounds.width,
                )
                .animation(.easeInOut.delay(0.2), value: animate)
                
                VStack(spacing: 20) {
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            path.append(AuthRoute.signUpView)
                        },
                        buttonLabel: "Continue with Email",
                        image: Image(.message),
                        textSize: 15
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(0.6), value: animate)
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            
                        },
                        buttonLabel: "Continue with Facebook",
                        labelColor: .black,
                        borderColor: .black,
                        image: Image(.facebook),
                        textSize: 15
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(0.7), value: animate)
                    
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            
                        },
                        buttonLabel: "Continue with Google",
                        labelColor: .black,
                        borderColor: .black,
                        image: Image(.google),
                        textSize: 15
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(0.8), value: animate)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
        .onAppear(perform: {
            animate = true
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateAccountView(
        path: .constant(NavigationPath())
    )
}
