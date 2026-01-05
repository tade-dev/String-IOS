//
//  PremiumView.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

struct Premium {
    var type: String
    var price: String
    var hearts: String
}

struct PremiumView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            
            HomeBackground()
            
            BlurredCircleBg(
                radius: 150
            )
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    HStack {
                        
                        AppBackButton {
                            dismiss()
                        }
                        .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : -20)
                    
                    Text("“String” Premium")
                        .stingerRegularFont(size: 30)
                        .foregroundStyle(Color(.white))
                        .padding(.bottom, 20)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.8)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Current Plans")
                            .stingerRegularFont(size: 20)
                            .foregroundStyle(Color(.white))
                            .opacity(animate ? 1 : 0)
                            .offset(x: animate ? 0 : -30)
                        
                        PremiumItems(premium: .init(type: "Bronze", price: "$6.99", hearts: "220"))
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 30)
                            .animation(.easeOut(duration: 0.5).delay(0.3), value: animate)
                        
                        PremiumItems(premium: .init(type: "Silver", price: "$17.99", hearts: "220"))
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 30)
                            .animation(.easeOut(duration: 0.5).delay(0.45), value: animate)
                        
                        PremiumItems(premium: .init(type: "Gold", price: "$29.99", hearts: "1020"))
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 30)
                            .animation(.easeOut(duration: 0.5).delay(0.6), value: animate)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.width)
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animate = true
            }
        }
    }
}

struct PremiumItems: View {
    
    let premium: Premium
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text(premium.type.capitalized)
                        .stingerRegularFont(size: 20)
                        .foregroundStyle(.white)
                    
                    Text(premium.price)
                        .foregroundStyle(.accent)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Get")
                        .stingerRegularFont(size: 20)
                        .foregroundStyle(.white)
                    
                    Text(premium.hearts)
                        .foregroundStyle(.accent)
                        .fontWeight(.semibold)
                    
                    Text("Hearts")
                        .stingerRegularFont(size: 20)
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                Text("See who likes your profile")
                    .stingerRegularFont(size: 20)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            Text("Buy \(premium.type) Premium")
                .stingerRegularFont(size: 20)
                .foregroundStyle(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    Color.accent
                }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1.5)
                .fill(.accent)
        }
        .cornerRadius(20)
        
    }
}

#Preview {
    PremiumView()
}
