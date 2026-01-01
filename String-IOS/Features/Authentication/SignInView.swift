//
//  SignInView.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct SignInView: View {
    
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Sign in")
                        .stingerBoldFont(size: 30)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut.delay(0.3), value: animate)
                    Text("Please enter below the details to continue")
                        .stingerRegularFont(size: 15)
                        .padding(.bottom, 30)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut.delay(0.4), value: animate)
                    
                    InputField(
                        placeholder: "Email",
                        prefixIcon: Image(.message)
                    )
                    .padding(.bottom, 20)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.5), value: animate)
                    InputField(
                        placeholder: "Password",
                        isPasswordField: true,
                        prefixIcon: Image(.passwordLock),
                        suffixIcon: Image(.hidePassword),
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.6), value: animate)
                    
                    HStack {
                        Text("Remember me")
                            .stingerRegularFont(size: 12)
                            .onTapGesture {
                                
                            }
                        Spacer()
                        Text("Forgot password?")
                            .stingerRegularFont(size: 12)
                            .onTapGesture {
                                
                            }
                    }
                    .padding(.top, 15)
                    
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, UIScreen.main.bounds.height * 0.1)
            }
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Image(.rightCurvedArrow)
                }
                .offset(
                    x: animate ? 0 : UIScreen.main.bounds.width,
                )
                .animation(.easeInOut.delay(0.7), value: animate)
                
                VStack(spacing: 20) {
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            path.append(AuthRoute.signUpView)
                        },
                        buttonLabel: "Sign in",
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(1.2), value: animate)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 20, content: {
                        Rectangle()
                            .frame(height: 1.5)
                        Text("or continue with")
                            .stingerRegularFont(size: 13)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Rectangle()
                            .frame(height: 1.5)
                    })
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(1.4), value: animate)
                    .padding(.bottom, 10)
                
                    HStack(spacing: 40) {
                        socialButtons(image: Image(.facebook))
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.bouncy.delay(1.6), value: animate)
                        socialButtons(image: Image(.google))
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.bouncy.delay(1.7), value: animate)
                        socialButtons(image: Image(.appleIcon))
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.bouncy.delay(1.8), value: animate)
                    }
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 0) {
                        Text("Don’t have an account yet? ")
                            .stingerRegularFont(size: 14)
                        
                        Text("Sign Up")
                            .stingerBoldFont(size: 14)
                            .foregroundStyle(.accent)
                            .onTapGesture {
                                path.append(AuthRoute.signUpView)
                            }
                    }
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.bouncy.delay(1.8), value: animate)
                    
                    
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
    
    func socialButtons(image: Image) -> some View {
        image
            .frame(width: 44, height: 44)
            .overlay {
                RoundedRectangle(cornerRadius: 11)
                    .stroke(.black)
            }
            .onTapGesture {
                
            }
    }
}

#Preview {
    SignInView(
        path: .constant(NavigationPath())
    )
}
