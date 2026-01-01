//
//  GenderView.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct GenderView: View {
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
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
                        Image(.vector)
                        
                        Text("Enter your user name")
                            .stingerBoldFont(size: 25)
                        
                        InputField(placeholder: "Enter your name")
                            .padding(.horizontal, 20)
                    }
                }
                Spacer()
                PrimaryBtn(
                    onButtonPressed: {
                        
                    },
                    buttonLabel: "Continue"
                )
                .padding(.horizontal, 20)
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
    GenderView(
        path: .constant(NavigationPath())
    )
}
