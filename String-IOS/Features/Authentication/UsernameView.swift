//
//  UsernameView.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct UsernameView: View {
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
    @State private var text: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            BlurredCircleBg()
            
            AuthIntroViewCircles()
            
            VStack {
                
                HStack {
                    AppBackButton(onTap: {
                        dismiss()
                    })
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Image(.username)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut, value: animate)
                        
                        Text("Enter your user name")
                            .stingerBoldFont(size: 25)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.1), value: animate)
                        
                        InputField(text: $text, placeholder: "Enter your name")
                            .padding(.horizontal, 20)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.2), value: animate)
                    }
                }
                Spacer()
                PrimaryBtn(
                    onButtonPressed: {
                        path.append(AuthRoute.gender)
                    },
                    buttonLabel: "Continue"
                )
                .padding(.horizontal, 20)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.7)
                .animation(.easeInOut.delay(0.3), value: animate)
                .padding(.bottom, 10)
            }

        }
        .onAppear(perform: {
            animate = true
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    UsernameView(
        path: .constant(NavigationPath())
    )
}
