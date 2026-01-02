//
//  VerifyImageView.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct VerifyImageView: View {
    
    @Binding var path: NavigationPath
    var image: UIImage?
    @State private var animate: Bool = false
    @State private var showPictureSelectionSheet: Bool = false
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
                    Text("Skip")
                        .stingerRegularFont(size: 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 5) {
                    Image(.verifyAccount)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut, value: animate)
                        .padding(.bottom, 15)
                    
                    HStack(content: {
                        Text("Verify")
                        Image(.verifyIcon)
                    })
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut.delay(0.15), value: animate)
                        .stingerBoldFont(size: 25)
                    
                    Text("Verify your pictures to become a verified profile. Open camera to take a selfie and image match the display picture.")
                        .stingerRegularFont(size: 15)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut.delay(0.25), value: animate)
                        .padding(.bottom, 40)
                    
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(height: 318)
                            .cornerRadius(30)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.3), value: animate)
                    } else {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                            .frame(height: 318)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.3), value: animate)
                    }
                    
                    
                }
                .padding(.horizontal, 15)
                Spacer()
                VStack(spacing: 20) {
                    PrimaryBtn(
                        onButtonPressed: {
                            
                        },
                        buttonLabel: "Open camera",
                        labelColor: .black,
                        borderColor: .black,
                    )
                    .padding(.horizontal, 20)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.4), value: animate)
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            
                        },
                        buttonLabel: "Continue"
                    )
                    .padding(.horizontal, 20)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.5), value: animate)
                    .padding(.bottom, 10)
                }
            }
        }
        .onAppear(perform: {
            animate = true
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VerifyImageView(
        path: .constant(NavigationPath()),
        image: UIImage()
    )
}
