//
//  PhotosView.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct PhotosView: View {
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
                    VStack(spacing: 5) {
                        Image(.bestPhotos)
                            .padding(.bottom, 15)
                        
                        Text("Add your best photos")
                            .stingerBoldFont(size: 25)                        
                        Text("Profile pictures leads to more matches")
                            .stingerRegularFont(size: 15)
                            .padding(.bottom, 15)
                        
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
    PhotosView(
        path: .constant(NavigationPath())
    )
}
