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
    
    enum Gender {
        case male
        case female
    }
    
    enum GenderInerest {
        case male
        case female
        case all
    }
    
    @State private var selectedGender: Gender? = nil
    @State private var selectedGenderInterest: GenderInerest? = nil
    
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
                
         
                VStack(spacing: 35) {
                    Image(.vector)
                        .opacity(animate ? 1 : 0)
                        .scaleEffect(animate ? 1 : 0.7)
                        .animation(.easeInOut, value: animate)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("What’s your Gender?")
                            .stingerBoldFont(size: 20)
                        
                        
                        GenderTileSelection(image: Image(.male), title: "Man", isSelected: selectedGender == .male) {
                            selectedGender = .male
                        }
                        GenderTileSelection(image: Image(.woman), title: "Woman", isSelected: selectedGender == .female) {
                            selectedGender = .female
                        }
                        
                    }
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.2), value: animate)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("What do you want to date?")
                            .stingerBoldFont(size: 20)
                        
                        GenderTileSelection(image: Image(.male), title: "Man", isSelected: selectedGenderInterest == .male) {
                            selectedGenderInterest = .male
                        }
                        GenderTileSelection(image: Image(.woman), title: "Woman", isSelected: selectedGenderInterest == .female) {
                            selectedGenderInterest = .female
                        }
                        GenderTileSelection(image: Image(.allGender), title: "All", isSelected: selectedGenderInterest == .all) {
                            selectedGenderInterest = .all
                        }
                        
                    }
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.7)
                    .animation(.easeInOut.delay(0.5), value: animate)
                }
                .padding(.horizontal, 20)
            
                Spacer()
                PrimaryBtn(
                    onButtonPressed: {
                        path.append(AuthRoute.birthday)
                    },
                    buttonLabel: "Continue"
                )
                .padding(.horizontal, 20)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.7)
                .animation(.easeInOut.delay(0.6), value: animate)
                .padding(.bottom, 10)
            }
        }
        .onAppear(perform: {
            animate = true
        })
        .navigationBarBackButtonHidden()
    }
}

struct GenderTileSelection: View {
    
    var image: Image
    var title: String
    var isSelected: Bool = false
    let onTap: ()-> Void
    
    var body: some View {
        HStack {
            image
            
            Text(title)
                .stingerRegularFont(size: 15)
            
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 56)
        .background {
            Color.accent
                .opacity(!isSelected ? 0 : 0.16)
        }
        .cornerRadius(50)
        .overlay {
            RoundedRectangle(cornerRadius: 50)
                .stroke(.black)
        }
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    GenderView(
        path: .constant(NavigationPath())
    )
}
