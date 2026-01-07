//
//  AppSettingsView.swift
//  String-IOS
//
//  Created by BSTAR on 05/01/2026.
//

import SwiftUI

struct AppSettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var animate: Bool = false
    
    var body: some View {
        
        ZStack {
            
            BlurredCircleBg()
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    HStack {
                        
                        AppBackButton {
                            dismiss()
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 12) {
                        Image(.settngs)
                        Text("App Setting")
                            .stingerRegularFont(size: 22)
                    }
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.spring, value: animate)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    VStack(spacing: 20) {
                        AppSettingTile(title: "Contact us")
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.5)
                            .animation(.spring.delay(0.2), value: animate)
                        AppSettingTile(title: "Location")
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.5)
                            .animation(.spring.delay(0.3), value: animate)
                        AppSettingTile(title: "Privacy Policy")
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.5)
                            .animation(.spring.delay(0.4), value: animate)
                        AppSettingTile(title: "Delete your account")
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.5)
                            .animation(.spring.delay(0.5), value: animate)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                    .padding(.bottom, 25)
                    
                    PrimaryBtn(
                        onButtonPressed: {
                            
                        },
                        buttonLabel: "Log Out"
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.spring.delay(0.6), value: animate)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4)
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.width)
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            animate = true
        }
    }
}

struct AppSettingTile: View {
    
    let title: String
    @State private var isOn: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .stingerRegularFont(size: 18)
            
            Spacer()
            Image(systemName: "chevron.forward")
                .foregroundStyle(.darkBackground)
        }
    }
    
}

#Preview {
    AppSettingsView()
}
