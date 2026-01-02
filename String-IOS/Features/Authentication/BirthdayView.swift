//
//  BirthdayView.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct BirthdayView: View {
    @Binding var path: NavigationPath
    @State private var animate: Bool = false
    @State private var showCustomDateSheet: Bool = false
    @State private var birthdayDate: String = ""
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
                        Image(.birthday)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut, value: animate)
                        
                        Text("When were you born?")
                            .stingerBoldFont(size: 25)
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.2), value: animate)
                        
                        InputField(text: $birthdayDate, placeholder: "Select date", textStyle: "")
                            .disabled(true)
                            .allowsHitTesting(true)
                            .onTapGesture {
                                showCustomDateSheet.toggle()
                            }
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay(0.3), value: animate)
                            .padding(.horizontal, 20)
                            .sheet(isPresented: $showCustomDateSheet) {
                                VStack(spacing: 0) {
                                    Text("Birthday")
                                        .stingerRegularFont(size: 25)
                                    
                                    CustomCalendarView(selectedData: $birthdayDate)
                                        .presentationDetents([.fraction(0.8), .large])
                                }
                                .padding(.top, 20)
                            }
                    }
                }
                Spacer()
                PrimaryBtn(
                    onButtonPressed: {
                        path.append(AuthRoute.photos)
                    },
                    buttonLabel: "Continue"
                )
                .padding(.horizontal, 20)
                .opacity(animate ? 1 : 0)
                .scaleEffect(animate ? 1 : 0.7)
                .animation(.easeInOut.delay(0.4), value: animate)
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
    BirthdayView(
        path: .constant(NavigationPath())
    )
}
