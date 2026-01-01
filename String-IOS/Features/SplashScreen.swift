//
//  SplashScreen.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        
        ZStack {
            
            //MARK: Background
            Color.darkBackground
                .ignoresSafeArea()
            
            //MARK: Positioned Circles
            SplashCircleWidgets()
            
            //MARK: Splash Icon
            StringLogo()
                .offset(x: animate ? 0 : -500, y: 0)
                .animation(.spring(response: 0.8, dampingFraction: 0.7), value: animate)
                .transition(.move(edge: .leading))
            
        }
        .onAppear {
            animate = true
        }

    }
}

#Preview {
    SplashScreen()
}
