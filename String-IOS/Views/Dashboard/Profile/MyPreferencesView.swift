//
//  MyPreferencesView.swift
//  String-IOS
//
//  Created by BSTAR on 05/01/2026.
//

import SwiftUI

struct MyPreferencesView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var animate: Bool = false
    
    var body: some View {
        
        ZStack {
            
            BlurredCircleBg()
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    HStack(spacing: 20) {
                        
                        AppBackButton {
                            dismiss()
                        }
                        
                        Text("My Preferences")
                            .stingerRegularFont(size: 22)
                            .foregroundStyle(.darkBackground)
                        
                        Spacer()
                        
                        Text("Edit Profile")
                            .stingerRegularFont(size: 13)
                            .foregroundStyle(.accent)
                        
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 0) {
                        Image(.man1)
                            .resizable()
                            .frame(width: 105, height: 105)
                            .clipShape(.circle)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                        
                        Text("Patrick Hale")
                            .stingerRegularFont(size: 22)
                        
                        Text("Sans Francisco US")
                            .stingerRegularFont(size: 15)
                            .foregroundStyle(.gray.opacity(0.8))
                            .padding(.bottom, 10)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("About me")
                                .stingerRegularFont(size: 18)
                                                    
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Placerat felis neque tincidunt id imperdiet aing rhoncus eget.")
                                .stingerRegularFont(size: 12)
                                .foregroundStyle(.darkBackground.opacity(0.5))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Photos")
                                .stingerRegularFont(size: 18)
                            LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 3)) {
                                ForEach(0..<8) { index in
                                    Image(.man1)
                                        .resizable()
                                        .frame(width: 91, height: 91)
                                        .clipShape(.circle)
                                        .padding(.top, 10)
                                }
                            }
                        }
                        
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
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

#Preview {
    MyPreferencesView()
}
